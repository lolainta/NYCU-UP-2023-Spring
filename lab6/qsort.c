#define SWAP(a,b) do{ \
    long temp=a; \
    a=b; \
    b=temp; \
}while(0)

void qsort(long arr[],int n){
    int stack[64]={0,n-1};
    int top=1;
    while(top>=0){
        int h=stack[top--];
        int l=stack[top--];
        int mid=(l+h)/2;
/*
#define p1 arr[l]
#define p2 arr[mid]
#define p3 arr[h]
        if(p2>p3)
            SWAP(p2,p3);
        if(p1>p2)
            SWAP(p1,p2);
        if(p2<p3)
            SWAP(p2,p3);
#undef p1
#undef p2
#undef p3
*/
        long pivot=arr[h];
        int i=l;
        for(int j=l;j<h;++j){
            if(arr[j]<=pivot){
                SWAP(arr[i],arr[j]);
                ++i;
            }
        }
        SWAP(arr[i],arr[h]);
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
