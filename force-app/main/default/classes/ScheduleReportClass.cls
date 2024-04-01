global class ScheduleReportClass implements Schedulable {
	global void Execute(SchedulableContext context){ 
        List <String> reportList = new List <String> {'Saddle_Rock_Camp_Lejune_Iuh', 'Saddle_Rock_Talcs_xr7'};
        ReportController.sendEmail(reportList);
 	}
}