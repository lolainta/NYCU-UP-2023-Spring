void qsort(long arr[],int n){
    quickSort(arr,0,n-1);
}
/*
void swap(long*a,long*b){
  long t=*a;
  *a=*b;
  *b=t;
}
*/

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
            i++;
            SWAP(array[i],array[j]);
        }
    }
    SWAP(array[i+1],array[high]);
    return i+1;
}

void quickSort(long array[],int low,int high){ 
    if(high-low<=8){
        for(int i=low;i<high;++i){
            for(int j=i+1;j<high;++j){
                if(array[i]>array[j])
                    SWAP(array[i],array[j]);
            }
        }
    }
    if(low<high){
        int pi=partition(array,low,high);
        quickSort(array,low,pi-1);
        quickSort(array,pi+1,high);
    }
}
