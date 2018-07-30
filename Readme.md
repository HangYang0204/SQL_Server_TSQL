# __Project example__

This is a place holder for projects used in TSQL term 6 class.


The request is to find the % of opt-ins/gross adds coming from the online channel by day pre and post BRM upgrade The BRM Upgrade went in Production on April 6th, 2018. Thus we chose from April 3rd to April 9th.

The business defines Opt in as follow:

>
> An opt-in is basically whenever an agent places an order in STARRS on a SelfPay plan, regardless of when the SelfPay Date occurs.
> If the SelfPay starts today or if it is a follow-on plan, both are opt-ins
>

The relationship with ActivationTag can be summerised as below:

>
> The ActivationTag from Scorecard will capture most, but not all Opt-ins:
>
> For Winbacks or for New/Used Conversions in which the trial expired, the opt-ins will take place right away/instantaneously. In these cases Scorecard will recognize these transactions because the SelfPay Date starts at the same time.
>
> For New/Used Conversions where the customer is still within trial, the opt-in will happen in STARRS but Scorecard won't recognize it, because the trial has not yet ended
>

To simplify, we only need to use all ActivationTag that is Neither NULL nor None for Opt in. The province can be found in __[TBL_ACCOUNT_ADDRESSINFO]__ table with address_type = 2.
In order to identify which sales is online sales, we used __[Employee]__ table, for those __Activation_source__ = 'web-Sonsumer', otherwise are not online sales.


The report is required in the following form:

| SnapshotDate | Province | ActivationTag | OnlineSales | OtherSales |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| 3-Apr-18 | Quebec | New Conversions | 5 | 20 |
| 3-Apr-18 | Other | Used Conversions | 7 | 36 |

The variable @startDate and @endDate can be set to capture values from user input from various sources like scheduled job, reporting front end or make it as parameters of a stored procedure.

The core logic of the report :

### __TODO__

Build report interface with Excel.
