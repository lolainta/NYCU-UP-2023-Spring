void qsort(long arr[],int n){
    int stack[64]={0,n-1};
    int top=1;
    while(top>=0){
        int h=stack[top--];
        int l=stack[top--];
        int p=partition(arr,l,h);
        if(p-1>l){
            stack[++top]=l;
            stack[++top]=p-1;
        }
        if(h>p+1){
            stack[++top]=p+1;
            stack[++top]=h;
        }
    }
}

#define SWAP(a,b) do{ \
    long temp=a; \
    a=b; \
    b=temp; \
}while(0)


inline int partition(long array[],int low,int high){
    long pivot=array[high];
    int i=(low-1);
    for(int j=low;j<high;j++){
        if(array[j]<=pivot){
            ++i;
            SWAP(array[i],array[j]);
        }
    }
    SWAP(array[i+1],array[high]);
    return i+1;
}
