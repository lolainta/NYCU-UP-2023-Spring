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

#include <linux/mm.h>
#include <linux/fs.h>
#include <asm/io.h>

static struct kshram_ds{
    void*data;
    int size;
}kshram_data[8];

static dev_t devnum;
static struct cdev c_dev;
static struct class*clazz;
static int major;
static int idx;

static int kshram_dev_open(struct inode*i,struct file*f){
    idx=iminor(i);
	printk(KERN_INFO "kshram: device idx=%d opened.\n",idx);
	return 0;
}

static int kshram_dev_close(struct inode*i,struct file*f){
	printk(KERN_INFO "kshram: device closed.\n");
	return 0;
}

static ssize_t kshram_dev_read(struct file*f, char __user*buf, size_t len,loff_t*off){
	printk(KERN_INFO "kshram: read %zu bytes @ %llu.\n",len,*off);
	return len;
}

static ssize_t kshram_dev_write(struct file*f, const char __user*buf,size_t len,loff_t*off){
	printk(KERN_INFO "kshram: write %zu bytes @ %llu.\n",len,*off);
	return len;
}

static long kshram_dev_ioctl(struct file*fp,unsigned int cmd,unsigned long arg){
	printk(KERN_INFO "kshram: ioctl cmd=%u arg=%lu\n",cmd,arg);
    if(cmd==_IO('K',0)){
        return 8;
    }else if(cmd==_IO('K',1)){
        return kshram_data[idx].size;
    }else if(cmd==_IO('K',2)){
        kshram_data[idx].data=krealloc(kshram_data[idx].data,arg,GFP_KERNEL);
        kshram_data[idx].size=arg;
        return 0;
    }
    printk(KERN_ERR "kshram: unknown command\n");
	return 0;
}

static int kshram_dev_mmap(struct file*file,struct vm_area_struct*vma){
    unsigned long len=vma->vm_end-vma->vm_start;
    unsigned long pfn;
    int ret;

    pfn=virt_to_phys(kshram_data[idx].data)>>PAGE_SHIFT;
    ret=remap_pfn_range(vma,vma->vm_start,pfn,len,vma->vm_page_prot);
    printk(KERN_INFO "kshram/mmap: idx %u size %lu\n",iminor(file_inode(file)),len);

    return ret;
}
static const struct file_operations kshram_dev_fops={
	.owner=THIS_MODULE,
	.open=kshram_dev_open,
	.read=kshram_dev_read,
	.write=kshram_dev_write,
	.unlocked_ioctl=kshram_dev_ioctl,
	.release=kshram_dev_close,
    .mmap=kshram_dev_mmap
};

static int kshram_proc_read(struct seq_file*m,void*v){
    for(int i=0;i<8;++i){
        seq_printf(m,"%02d: %d\n",i,kshram_data[i].size);
    }
	return 0;
}

static int kshram_proc_open(struct inode*inode,struct file *file) {
	return single_open(file,kshram_proc_read,NULL);
}

static const struct proc_ops kshram_proc_fops={
	.proc_open=kshram_proc_open,
	.proc_read=seq_read,
	.proc_lseek=seq_lseek,
	.proc_release=single_release,
};

static char *kshram_devnode(const struct device*dev,umode_t*mode) {
	if(mode==NULL) return NULL;
	*mode=0666;
	return NULL;
}

static int __init kshram_init(void){
	// create char dev
	if(alloc_chrdev_region(&devnum,0,8,"updev")<0)
		return -1;
	if((clazz=class_create(THIS_MODULE,"upclass"))==NULL){
		goto release_region;
    }
	clazz->devnode=kshram_devnode;
    major=MAJOR(devnum);
    for(int i=0;i<8;++i){
        if(device_create(clazz,NULL,MKDEV(major,i),NULL,"kshram%d",i)==NULL){
            printk(KERN_ERR "kshram: init failed\n");
            goto release_class;
        }
        kshram_data[i].size=4096;
        kshram_data[i].data=kzalloc(4096,GFP_KERNEL);
        printk(KERN_INFO "kshram%d: %d bytes allocated @ %p\n",i,kshram_data[i].size,kshram_data[i].data);
    }
    cdev_init(&c_dev,&kshram_dev_fops);
    if(cdev_add(&c_dev,devnum,8)==-1){
        goto release_device;
    }

	// create proc
	proc_create("kshram",0,NULL,&kshram_proc_fops);

	printk(KERN_INFO "kshram: initialized.\n");
	return 0;    // Non-zero return means that the module couldn't be loaded.

release_device:
	device_destroy(clazz,devnum);
release_class:
	class_destroy(clazz);
release_region:
	unregister_chrdev_region(devnum,1);
	return -1;
}

static void __exit kshram_cleanup(void){
	remove_proc_entry("kshram",NULL);

    for(int i=0;i<8;++i){
        kfree(kshram_data[i].data);
	    device_destroy(clazz,MKDEV(MAJOR(devnum),i));
    }
	cdev_del(&c_dev);
	class_destroy(clazz);
	unregister_chrdev_region(devnum,1);

	printk(KERN_INFO "kshram: cleaned up.\n");
}

module_init(kshram_init);
module_exit(kshram_cleanup);

MODULE_LICENSE("GPL");
