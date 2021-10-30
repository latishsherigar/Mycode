#include<stdio.h>
#include<string.h>
/*#include<io.h>
#include <fcntl.h>
*/

struct{
	char fname[15];
	int files;
      }d;

void split();
void merge();
void incfileno(int xyz,char* target);
void author();
void help();
long getfilesize(char *filename);


/*==========================MAIN fun=================================*/
 int main()
{
int choice;
char ch;

while(1)
{
  printf("\n\t\t\t\tSPLITTER\n\t\t\t\t________\n\n\n\n");
  printf("\n\n\n1.Splitter.");
  printf("\n\n2.Merger.");
  printf("\n\n3.Help.");
  printf("\n\n4.Author.");
  printf("\n\n5.Exit");
  printf("\n\n\n\nEnter your choice: ");
  fflush(stdin);
  scanf("%d",&choice);

  switch(choice)
   {
     case 1:split();
            break;
     case 2:merge();
            break;
     case 3:help();
            break;
     case 4:author();
            break;
     case 5:return(0);
   }

   printf("\n\n\n\nWant to continue(y/n):");
   fflush(stdin);
   scanf("%c",&ch);
   ch=tolower(ch);
   if((ch!='y')||(ch!='Y'))
     {  return(0);
     }
}

/*-------------------accept_filename function------------*/

void accept_filename(char * filename)
 {
   char ch;
   double filesize;
  while(1)
  {
   printf("\n File name(or path) :");
   fflush(stdin);
   gets(filename); 
   filesize=getfilesize(filename);          /*get the length of the file*/
 
   fs=fopen(filename,"rb");                /*open file in read mode*/
   if (fs==NULL)
    {
     printf("\n\nFile %s missing.n\n\n\n",source);
     printf("\nDo you want to try again(y/n):");
     fflush(stdin);
     ch=getch();
    
     if((ch!='y')||(ch!='Y'))
       {
        strcpy(filename,"");
        break;
       }
     }
    else{
         printf("\n\n\n\n\nFile length :%5.0f %cbytes ",a,b);
         break;
         }
   }
 }

/*--------------------accept_outputdir funhction-----------------*/

void accept_outputdir(char *outputdir)
 {
  char ch;
    
  while(1)
  {
   printf("\n\n\nOutput directory (Press 'ENTER' key if in the same directory:");
   fflush(stdin);
   gets(outputdir); 
   
   fs=fopen("temp.temp","wb");                /*open test file in write mode*/
   if (fs==NULL)
    {
     printf("\n\nCannot write in the specified directory\n\n\n");
     printf("\nDo you want to try again(y/n):");
     fflush(stdin);
     ch=getch();
    
     if((ch!='y')||(ch!='Y'))
       {
        strcpy(outputdir,"");
        break;
       }
     }
    else{
         break;
        }
   }
 }


/*--------------------formatfilelength--------------------*/

char print_formatted_filelength(double filesize)
{
 char formatchar;

 if(filesize <= 1000)
  {
   a=filesize;
  formatchar=' ';
  }

 if(filesize > 1000 && filesize < 1000000)
   {
   a=filesize*0.001;
  formatchar='K';
   }

 if(filesize >= 1000000 && filesize < 1000000000)
  {
   a=filesize * 0.000001;
  formatchar='M';
  }

 if(filesize >= 1000000000)
  {
   a=filesize * 0.000000001
  formatchar='G';
  }
  
 return(formatchar);
}

/*------------------show_split_formatmenu function---------------*/
int show_split_formatmenu(formatchar)
{
 int temp=1;

 if(formatchar != ' ')
   {
     printf("\n\nEnter the format in which you want your files to be broken:\n");

     if((formatchar=='M') || (formatchar=='G'))
       {
        printf("\n(%d)  1.44Mb Floppy Disk .",temp);
        ++temp;
        printf("\n(%d)   Megabytes .",temp);
        ++temp;
       }

     if(formatchar=='K')
       {
        printf("\n(%d)   Kilobytes .",temp);
        ++temp;
        printf("\n(%d)   Bytes .",temp);
       }
   }
 else{
     printf("\n\nEnter the size in bytes:\n");
     }

   }
   

/*--------------------accept_split_format_choice-------------------*/
int accept_split_format_choice(char formatchar)
{
 int choice=0,temp;

  while(1)
   {
     printf("\n\nEnter your choice:");
     fflush(stdin);
     scanf("%d",&temp);
     
     switch(formatchar)
       {
        case 'G':
        case 'M':choice=temp;
		 break; 
        case 'K': if(temp == 1)
                    {
                     choice=3; 
                    }
                  else{
                     choice=4; 
                   }
                   break;
       }

       if(choice < 1 || choice >4)
         {
           printf("\n\nInvalid choice........");
           printf("\nDo you want to try again(y/n):");
           fflush(stdin);
           ch=getche();
           if(ch!='y'||ch!='Y')
             {
               return(0);              
	     }
            else{
                 return(-1);
		}
         }
       else{
	      return(choice);
	    }
   }
 }

/*--------------------accept split file size----------------------*/
double accept_splitfilesize(int choice,double filesize)
{ 
  char strtemp[15];
  char ch;
  double entsize,splitsize;
  long convmultiple;

  switch(choice)
    {
     case 1: splitsize=1380000;
             break;

     case 2:strcpy(strtemp,"Megabytes");
            convmultiple=1000000;
	    break;

     case 3:strcpy(strtemp,"Kilobytes");
	    convmultiple=1000;
	    break;

     case 4:strcpy(strtemp,"bytes");
	   convmultiple=1;
	   break;
    }

    printf("\n\nEach part size(in %s): " ,strtemp);
    fflush(stdin);
    scanf("%f",&entsize);
    splitsize = convmultiple * entsize;

    if(splitsize > filesize)
      {
        printf("\n\nInvalid partsize.\nPart size greater than total file size.\n\n\n\n");
        printf("\n\nDo you want to try again(y/n):");
        fflush(stdin);
        ch=getche();
        if(ch=='y'||ch=='Y')
           {
            return(0);
           }
        else{
             return(-1);
             }
       }
       else{
         printf("\nWant to change the number of parts(y/n):");
         fflush(stdin);
         ch=getche();
         if(ch=='y'||ch=='Y')
           {
             return(0);
           }
          else{
             return(splitsize);            
           }
        }
}


/*-----------------------accept_lastpartsize function---------------------------*/
int accept_lastpartsize(double filesize,double splitsize,double *lastpartsize,int *totalparts)
{
 totalparts=(filesize/splitsize)+1;
 *(lastpartsize)=filesize -(splitsize*(totalparts-1));
 if(*(totalparts) > 999)
  {
   printf("\n\n\n\nToo many parts to create.Please reduce the number of parts.");
   fflush(stdin);
   printf("\n\n\n\nDo you want to try again(y/n):.");
   ch=getche();
   if(ch=='y'||ch=='Y')
     {
      return(0);
      }
   else{
         return(-1);
        }
  }
  else{
        return(1);
      }
}

/*---------------------splitfiles-------------------------------*/
int splitfiles()
{
 printf("\n\nBreaking files.....\n\n");
 printf("\n\nPress 'ESC' to abort operation."); 
 strcat(target,source);
 
 ft=fopen(target,"wb");

 if(ft==NULL)
  {
   printf("\n\nFile %s missing.",target);
   exit(1);
  }

 strcpy(d.fname,source);
 d.files=totalparts;
 fwrite(&d,sizeof(d),1,ft);
 splitsize=size;
 
 for(i=0;i<totalparts;++i)
 {
   printf("Percent Completed :%d",progress);
   
  if(i==(totalparts-1))
   {
   splitsize=lastpartsize;
   }

  z=0;

  while(z < splitsize)
    {
     fread(buff,1,1,fs);
     fwrite(buff,1,1,ft);
     ++z;
    }

  fclose(ft);

  if(i<totalparts-1)
   {
    incfileno(i+1,target);
    ft=fopen(target,"wb");

    if(ft==NULL)
     {
       printf("\n\nFile %s missing.",target);
       getch();
       exit(1);
     }
 }
}
fclose(fs);
fclose(ft);
fclose(fcs);
fclose(fct);

}
/*====================Split function==============================*/

void  split()
{
 char source_filename[100],char outputdir[100];
 char strm[]="Megabytes",strk[]="Kilobytes",strb[]="Bytes",buff[3];
 char b,ch,formatchar;
 FILE *fs,*ft,*fcs,*fct;
 int i=0,choice=0,totalparts=0,temp,slow=0;
 double filesize=0;
 float convmultiple=0,entsize=0,z,splitsize=0,a=0,lastpartsize=0;
 
/*accept the source filename*/
accept_filename(source_filename);


/*accept the target output directory*/
accept_outputdir(char *outputdir);

/*get the file size*/
filesize=getfilesize(filename);

/*print the formatted filelength*/
formatchar=print_formatted_filelength(filesize)

while(1)
{
 /*show the splitting format menu*/
 show_split_formatmenu(formatchar);

 /*accept the split format*/
 retval=accept_split_format_choice(formatchar)
  if(retval==-1)
   {
    exit(0);
   }
 elseif(retval==0)
      { 
       continue;
      }

 /*accept the split size*/
 retval=accept_splitfilesize(choice,filesize)
  if(retval==-1)
   {
    exit(0);
   }
 elseif(retval==0)
      { 
       continue;
      }

 /*accept the last part size*/
 retval=accept_lastpartsize(filesize,splitsize,&lastpartsize,&totalparts)
 if(retval==-1)
   {
    exit(0);
   }
 elseif(retval==0)
      { 
       continue;
      }
}

}


 /*====================merge fun==============================*/

void merge()
 {
 FILE*fs,*ft;
 int a=0;
 char buff[4],source[100],target[100];

fflush(stdin);
printf("\n File name :");
printf("\n(Full Path name optional)");
strcpy(source,fname);
source[0]='0';
source[1]='0';
source[2]='0';
fs=fopen(source,"rb");
if(fs==NULL)
  {printf("\n\n\nFile %s missing. ",source);
  printf("\n\nFile name may be invalid.");
  getch();
   goto start;
  }

 fread(&d,sizeof(d),1,fs);
 fclose(fs);
 printf("\n\n\nOutput directory:");
 printf("\n(Press 'ENTER' if in working directory.)");
 printf("\n\n\n\n\n%s\n%d",d.fname,d.files);
 ft=fopen(d.fname,"wb");
 if(ft==NULL)
 {printf("\n\nFile %s cannot be opened.",d.fname) ;
 getch();
 }


strcpy(pathindir,tempglobal);
if(indir(1)==1)
{goto start;
}
fs=fopen(source,"rb");
if(fs==NULL)
  {printf("\n\n\nFile %s missing. ",source);
   goto start;
  }

 fread(&d,sizeof(d),1,fs);
 printf("\n\n\n\n\nFile merging started\n\n\n");

 for(a=0;a<d.files;++a)
 { printf(" * ");
 while(fread(buff,1,1,fs)==1)
 {fwrite(buff,1,1,ft);
 }
 fclose(fs);
if(a<d.files-1)
{
 incfileno(a+1,source);
 fs=fopen(source,"rb");
if(fs==NULL)
  {printf("\n\n\nFile %s missing.",source);
   getch();
    exit(0);
  }

 }
}
fclose(ft);
fclose(fs);

}

/*==getfilesize function===*/
long getfilesize(char *filename)
{
 long handle;
 long filesize;
 handle = open(filename, O_RDONLY);
 if(handle!=-1)
  {
    filesize=filelength(handle);
  }
 else
  {
  filesize=0;
  }
   
   close(handle);
    return(filesize);
  }
/*=======================incfileno fun======================*/
void incfileno(int xyz,char* target)
{ 
  int x,y,z,modx,mody;
  
  x = xyz / 100;
  modx = xyz % 100;
  y = modx / 10;
  mody = modx % 10;
  z=mody;
  x+=48;
  y+=48;
  z+=48;
  *(target+0)=x;
  *(target+1)=y;
  *(target+2)=z;
}

 /*====================Author fun===================*/
void  author()
{
printf("\n\n\n\t\t\t\tSPLITTER\n\t\t\t\t--------");
printf("\n\n\n\n\n\n\tProgram author: LATISH SHERIGAR");
printf("\n\n\n\tEmail id: latishsherigar@yahoo.co.in");
printf("\n\n\tWebsite: http://www.geocities.com/latishsherigar");
printf("\n\n\n\tProg version: 1.1");
printf("\n\n\n\n\tPress any key to continue............") ;
getch();
}

/*============== =================HELP fun==========================*/

void help()
{
clrscr();
printf("\n\n\nSPLITTER-:\n");
printf("\nFor splitting any files just give the name of the file or full directory path\n of the file if the file is in other directory. ");
printf("\nIt then asks for the output directory.Press ENTER if in the working directory orgive the full path if in other directory.");
printf("\nThe Program then asks the memory format in which you want your files to be");
printf("\nbroken to.Just enter the required format .It then asks for the size of the");
printf("\nindividual parts.");
printf("\nJust enter this and BINGO! your file is broken.");
printf("\n\n\nMERGER-:\n\n");
printf("\nThe procedure for merging the files is similar as splitting .");
printf("\nFor merging the files ,just give the name of any 1 splitted file to be \nmergeted.");
printf("\nThe program then asks for output directory.");
printf("\nThe program then does the rest for you.");
printf("\n\nPress any key to continue...........");
getch();
}












