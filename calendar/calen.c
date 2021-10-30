#include<stdio.h>

main()
{
int year,month,first_of_month,month_days;

accept(&year,&month);

if(validate(year,month))
 {
   first_of_month=findfirstofmonth(month,year);
   month_days=finddays(month);
   formatcalen(first_of_month,month_days);
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
    if(year >= 0)
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
            printf("\nYear should be a number between 1 and xxxxxxx\n");
    	}

    return(0);
}

/*-----------findfirstofmonth function----------------------------------------------------*/

int findfirstofmonth(int month,int year)
{

 int i,first_of_month,first_of_jan=1,noofdays;
  /*loop till the previous month*/
  /*find the total no of days ,divide it by 7 and add the remainder to the first of jan.*/

  for(i=1;i<year;++i)
  {
    if(findleapyr(i)==28)
      {
        noofdays=365;
      }
    else{
       noofdays=366;
    }
    first_of_jan=(noofdays % 7) + first_of_jan ;
    /*to maintain the no between 0(sunday) and 6(saturday)*/
    first_of_jan=first_of_jan % 7;
  }

  /*reset the variable*/
 noofdays=0;

 for(i=1;i<month;++i)
  {
    noofdays=finddays(i,year) + noofdays;
  }

  if(month==1)
  {
    first_of_month= first_of_jan;
  }
  else{
       first_of_month=(noofdays % 7) + first_of_jan;
  }

  first_of_month=first_of_month % 7;

  return(first_of_month);
}

/*--------------------finddays function----------------------------------------------*/
/*the functon returns the number of days in a month of a particular year*/
int finddays( int month,int year)
{
  switch(month)
   {
    case 1: case 3: case 5: case 7: case 8: case 10: case 12:  return(31);
    case 4: case 6: case 9: case 11: return(30);
    case 2:  return(findleapyr(year));
   }
}

/*---------------------findleapyear function---------------------------*/

int findleapyr(year)
{
  /*if the year is not divisible by 4 then it is  a leap year.*/
  if((year%4)==0)
    {
    /*if further the year is divisible by 100 and if its divisible by 400 then*/
    /*only its a leap yr*/
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
 int i,j=0;
 int count=0;
 char dates[100];
 char strtemp[4];

 printf("\n\nSUN MON TUE WED THU FRI SAT");

    while(j<day)			/*write no 0 in the array where a space is present*/
      {
  	dates[j]=0;
   	++j;
      }

     for(i=0;i<noofdays;++i)		/*write the normal dates into the array*/
     {
      dates[i+j]=i+1;
     }

     count=i+j;

     for(i=0;i<count;++i)		/*display the calendar*/
      {
	if((i%7)==0)
	 {
	   printf("\n");
	 }


	if(dates[i]==0)				/*if the date is 0 then add 4 spaces*/
	 {
	   printf("    ");
	 }
	else{
     	     if(dates[i]<10)			/*if the date is a 2 digit no i.e. >9*/
	      {
	        printf(" ");			/*add a leading space*/
	        printf("%d",dates[i]);
	      }
	      else{
		printf("%d",dates[i]);
	      }
                printf(" ");
		printf(" ");
	}
      }
      printf("\n\n");
 }
