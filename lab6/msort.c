void merge_sort(long* a, int n){
    int m = (n + 1) / 2;
    if (m > 1)
        merge_sort(a, m);
    if (n - m > 1)
        merge_sort(a + m, n - m);
    merge(a, m, n - m);
}

#define __INSERT_THRESH 5
#define __swap(x, y) (t = *(x), *(x) = *(y), *(y) = t)
void merge(long* a, int an, int bn){
    long *b = a + an, *e = b + bn, *s, t;
    if (an == 0 || bn == 0 || !(*b < *(b - 1)))
        return;
    if (an < __INSERT_THRESH && an <= bn) {
        for (long *p = b, *v; p > a; p--)
            for (v = p, s = p - 1; v < e && *v < *s; s = v, v++)
                __swap(s, v);
        return;
    }

    if (bn < __INSERT_THRESH) {
        for (long *p = b, *v; p < e; p++)
            for (s = p, v = p - 1; s > a && *s < *v; s = v, v--)
                __swap(s, v);
        return;
    }
    long *pa = a, *pb = b;
    for (s = a; s < b && pb < e; s++)
        if (*pb < *pa)
            pb++;
        else
            pa++;
    pa += b - s;
    for (long *la = pa, *fb = b; la < b; la++, fb++)
        __swap(la, fb);
    merge(a, pa - a, pb - b);
    merge(b, pb - b, e - pb);
}
#undef __swap
#undef __INSERT_THRESH
