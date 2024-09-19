// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

CTPersonController.getPersonById('a06dL0000039S3NQAU');

List<Location_Tracing__c> records = [
  SELECT Id, Name, Person__c, Location__c
  FROM Location_Tracing__c
];

for (Location_Tracing__c record : records) {
  System.debug('Record: ' + record);
}

System.debug(CTPersonController.getToken('6354487524'));

Location_Tracing__c trace1 = new Location_Tracing__c(Person__c = 'a06dL000004ImofQAC', Location__c = 'a04dL000000yEMfQAM');
Location_Tracing__c trace2 = new Location_Tracing__c(Person__c = 'a06dL000004Ik6wQAC', Location__c = 'a04dL000000yEMfQAM');
Location_Tracing__c trace3 = new Location_Tracing__c(Person__c= 'a06dL000004IqqfQAC', Location__c = 'a04dL000000yEMfQAM');

List<Location_Tracing__c> newTraces = new List<Location_Tracing__c>();

newTraces.add(trace1);
newTraces.add(trace2);
newTraces.add(trace3);

List<Location_Tracing__c> duplicates = CTLocationTrackingController.checkDuplicates(newTraces);
System.debug('Duplicates : '+ duplicates);
System.debug('Duplicates Size : '+ duplicates.size());

AggregateResult[] groupedResults = [SELECT AVG(Amount) avgAmount, MAX(Amount) maxAmount FROM Opportunity];
System.debug('GroupedResults : '+ groupedResults);
System.debug('Average Amount of All Opportunities: '+ groupedResults[0].get('avgAmount'));
System.debug('Max Amount of All Opportunities: '+ groupedResults[0].get('maxAmount'));

for(AggregateResult result: [SELECT StageName,AVG(Amount) avgAmount, MAX(Amount) maxAmount FROM Opportunity GROUP BY StageName]) {
  System.debug('Stage Name: '+ result.get('StageName')+ ' Avg Amount: '+ result.get('avgAmount')+ ' Max Amount: '+ result.get('maxAmount'));
}

System.debug('Get Status : '+ CTLocationController.getStatusCount());