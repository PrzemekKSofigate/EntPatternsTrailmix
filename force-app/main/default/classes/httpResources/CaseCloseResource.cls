@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    
    @HttpPost
    global static void closeCase(String reason) {
        Id caseId = extractCaseId();
        CaseService.closeCases(new Set<Id> {caseId}, reason);
    }

    private static Id extractCaseId() {
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        return uriParts[2];
    }
}