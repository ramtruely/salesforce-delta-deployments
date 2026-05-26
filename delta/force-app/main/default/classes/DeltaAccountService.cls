@isTest
private class DeltaAccountService {

    @isTest
    static void testGetMessage() {

        String result = DeltaAccountService.getMessage();

        System.assertEquals(
            'Delta v2 deployment POC',
            result
        );
    }
}