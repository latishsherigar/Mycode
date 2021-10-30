#include<stdio.h>
main()
{
 char file1[50],file2[50];
 FILE *f1,*f2;
 char buff1[1],buff2[1];
 double count1=0,count2=0;
int a,b;

 printf("file1:");
 scanf("%s",file1);
 printf("%s\n",file1);
 f1=fopen(file1,"rb");

 printf("file2:");
 scanf("%s",file2);
printf("%s\n",file1);

 f2=fopen(file2,"rb");
 
 while(1)
 {
     
a=fread(buff1,sizeof(buff1),1,f1);
b=fread(buff2,sizeof(buff2),1,f2);
if((a==0)&&(b==0))
{
 printf("Files Identical\n");
 printf("File1 location:%15.0f\n",count1);
 printf("File1 location:%15.0f\n",count2);
 break;
}

 /*printf("%d %d\n",buff1[0],buff2[0]);*/  
 if(buff1[0]!=buff2[0])
    {
      printf("Not Identical\n");
      printf("File1 location:%15.0f\n",count1);
      printf("File1 location:%15.0f\n",count2);      
      break;
    }
++count1;
++count2;
  }
}