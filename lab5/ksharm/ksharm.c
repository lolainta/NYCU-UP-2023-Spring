/*
 * Lab problem set for UNIX programming course
 * by Chun-Ying Huang <chuang@cs.nctu.edu.tw>
 * License: GPLv2
 */
#include <linux/module.h>	// included for all kernel modules
#include <linux/kernel.h>	// included for KERN_INFO
#include <linux/init.h>		// included for __init and __exit macros
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/errno.h>
#include <linux/sched.h>	// task_struct requried for current_uid()
#include <linux/cred.h>		// for current_uid();
#include <linux/slab.h>		// for kmalloc/kfree
#include <linux/uaccess.h>	// copy_to_user
#include <linux/string.h>
#include <linux/device.h>
#include <linux/cdev.h>

static dev_t devnum;
static struct cdev c_dev;
static struct class*clazz;
static int major;

static int ksharm_dev_open(struct inode *i, struct file *f) {
	printk(KERN_INFO "ksharm: device opened.\n");
	return 0;
}

static int ksharm_dev_close(struct inode *i, struct file *f) {
	printk(KERN_INFO "ksharm: device closed.\n");
	return 0;
}

static ssize_t ksharm_dev_read(struct file *f, char __user *buf, size_t len, loff_t *off) {
	printk(KERN_INFO "ksharm: read %zu bytes @ %llu.\n", len, *off);
	return len;
}

static ssize_t ksharm_dev_write(struct file *f, const char __user *buf, size_t len, loff_t *off) {
	printk(KERN_INFO "ksharm: write %zu bytes @ %llu.\n", len, *off);
	return len;
}

static long ksharm_dev_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
	printk(KERN_INFO "ksharm: ioctl cmd=%u arg=%lu.\n", cmd, arg);
	return 0;
}

static const struct file_operations ksharm_dev_fops = {
	.owner = THIS_MODULE,
	.open = ksharm_dev_open,
	.read = ksharm_dev_read,
	.write = ksharm_dev_write,
	.unlocked_ioctl = ksharm_dev_ioctl,
	.release = ksharm_dev_close
};

static int ksharm_proc_read(struct seq_file *m, void *v) {
	char buf[] = "`hello, world!` in /proc.\n";
	seq_printf(m, buf);
	return 0;
}

static int ksharm_proc_open(struct inode *inode, struct file *file) {
	return single_open(file, ksharm_proc_read, NULL);
}

static const struct proc_ops ksharm_proc_fops = {
	.proc_open = ksharm_proc_open,
	.proc_read = seq_read,
	.proc_lseek = seq_lseek,
	.proc_release = single_release,
};

static char *ksharm_devnode(const struct device *dev, umode_t *mode) {
	if(mode == NULL) return NULL;
	*mode = 0666;
	return NULL;
}

static int __init ksharm_init(void)
{
	// create char dev
	if(alloc_chrdev_region(&devnum,0,8,"updev")<0)
		return -1;
	if((clazz=class_create(THIS_MODULE, "upclass")) == NULL)
		goto release_region;
	clazz->devnode=ksharm_devnode;
    major=MAJOR(devnum);
    for(int i=0;i<8;++i){
        if(device_create(clazz,NULL,MKDEV(major,i),NULL,"ksharm%d",i)==NULL)
            goto release_class;
    }
    cdev_init(&c_dev,&ksharm_dev_fops);
    if(cdev_add(&c_dev,devnum,1)==-1)
        goto release_device;

	// create proc
//	proc_create("ksharm", 0, NULL, &ksharm_proc_fops);

	printk(KERN_INFO "ksharm: initialized.\n");
	return 0;    // Non-zero return means that the module couldn't be loaded.

release_device:
	device_destroy(clazz, devnum);
release_class:
	class_destroy(clazz);
release_region:
	unregister_chrdev_region(devnum, 1);
	return -1;
}

static void __exit ksharm_cleanup(void)
{
	remove_proc_entry("ksharm", NULL);

	cdev_del(&c_dev);
	device_destroy(clazz, devnum);
	class_destroy(clazz);
	unregister_chrdev_region(devnum, 1);

	printk(KERN_INFO "ksharm: cleaned up.\n");
}

module_init(ksharm_init);
module_exit(ksharm_cleanup);

MODULE_LICENSE("GPL");
