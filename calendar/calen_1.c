#include<stdio.h>

int globalnoofdays=31;


main()
{
int year,month,first_of_jan,first_of_month;
int temp;

accept(&year,&month);

if(validate(year,month))
 {
   first_of_jan=findfirstofjan(year);
   first_of_month=findfirstofmonth(month,year,first_of_jan);
   formatcalen(first_of_month,finddays(month));
 }
}


/*--------accept year and function*/

accept(int * year,int * month)
{
printf("Year:");
scanf("%d",year);
printf("Month:");
scanf("%d",month);
}


/*---------validate year function----------------*/

int validate(int year,int month)
{
    if(year >= 0 && year <= 4900)
    {
       if(month >0 && month <13)
          {
 	    return(1);
	  }
       else{
             printf("Month should be a number between 1 and 12.\n");
           }
    }
    else{
            printf("\nYear should be a number between 1900 and 4900\n");
    	}

    return(0);
}


/*----------------------------------------------------------------*/
int findfirstofjan(int year)
{
int a ,b,day=1;

for(a=1900;a<year;++a)
{
 b=findleapyr(a);
 if(b==29)
  {
    if(day<=5)
      {
       day=day+2;
      }
    else{
	 if(day==6)
	   {
	    day=1;
	   }
	  else{
	       day=2;
	      }
	 }
  }
 else{
       if(day<=6)
	 {
	  day=day+1;
	 }
       else{
	    day=1;
	   }
     }
 }
  return(day);
}

/*---------------------------------------------------------------*/

/*int findfirstofmonth(int month,int year,int first_of_jan)
{
int day;
int i,noofdays,int first_of_month;

day=first_of_jan;

if(month==1)
  {
   return(first_of_jan);
  }

 for(i=1;i<month;++i)
 {
  noofdays=finddays(i,year);

    switch(noofdays)
	{
	 case 28:  break;

	 case 29: if(day<=6)
		   {
		    day=day+1;
		   }
		   else{
			day=1;
		       }
		   break;

	  case 30: if(day<=5)
		    {
		     day=day+2;
		    }
		    else{
			  if(day==6)
			    {
			     day=1;
			    }
			   else{
				day=2;
			       }
			}
		      break;

	   case 31: if(day<=4)
		    {
		     day=day+3;
		    }
		    else{
			  if(day==5)
			    {
			     day=1;
			    }
			   else{
				if(day==6)
				  {
				   day=2;
				  }
				else {
				       day=3;
				     }
				}
			}
		      break;


	}
 }
return(day);
}
*/

/*---------------------------------------------------------------*/

int findfirstofmonth(int month,int year,int first_of_jan)
{

int i,noofdays,first_of_month;


if(month==1)
  {
   return(first_of_jan);
  }

  /*loop till the previous month*/
  /*find the total no of days ,divide it by 7 and add the remainder to the actual day.*/
 for(i=1;i<month;++i)
 {
  noofdays=finddays(i,year) + noofdays;
 }


 first_of_month=(noofdays%7)+first_of_jan;

 return(first_of_month);
}

/*------------------------------------------------------------------*/

int finddays( int month,int year)
{
  switch(month)
   {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:  return(31);

    case 4:
    case 6:
    case 9:
    case 11:  return(30);

    case 2:  return(findleapyr(year));

   }
}

/*-----------------------------------------------------------------*/

int findleapyr(year)
{
  if((year%4)==0)
    {
     if((year%100)==0)
       {
	if((year%400)==0)
	  {
	   return(29);
	  }
	else{
	     return(28);
	    }
       }
     else{
	 return(29);
	 }
    }
  else{
       return(28);
      }
}

/*--------------------------------------------------------------------*/

 formatcalen(int day,int noofdays)
 {
 int a=1;
 int count=0;
 count=day;

printf("\n\n\tMON\tTUE\tWED\tTHU\tFRI\tSAT\tSUN\n\n");
 while(a<day)
 {
  printf("\t");
  ++a;
 }
 for(a=1;a<=noofdays;++a)
 {
 if(count==8)
   {
    printf("\n\n");
    count=1;
   }
   printf("\t %d",a);
   ++count;
 }
printf("\n\n");
 }
