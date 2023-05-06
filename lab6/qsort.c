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

        long pivot=arr[h];
        int i=(l-1);
        for(int j=l;j<h;j++){
            if(arr[j]<=pivot){
                ++i;
                SWAP(arr[i],arr[j]);
            }
        }
        SWAP(arr[i+1],arr[h]);

        int p=i+1;

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
