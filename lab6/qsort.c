inline void swap(long*a,long*b){
    long tmp=*a;
    *a=*b;
    *b=tmp;
}

void qsort(long arr[],int n){
    int stack[64]={0,n-1};
    int top=1;
    while(top>=0){
        int h=stack[top--];
        int l=stack[top--];

        long pivot=arr[h];
        int i=l,j=h-1;
        while(i<h && arr[i]<=pivot) ++i;
        for(;j>i;--j){
            if(arr[j]<=pivot){
                swap(&arr[i],&arr[j]);
                do{
                    ++i;
                }while(i<h && arr[i]<=pivot);
            }
        }
        swap(&arr[i],&arr[h]);

        if(i-1>l){
            stack[++top]=l;
            stack[++top]=i-1;
        }
        if(h>i+1){
            stack[++top]=i+1;
            stack[++top]=h;
        }
    }
}
