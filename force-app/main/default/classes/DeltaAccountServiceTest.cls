@isTest
private class DeltaAccountServiceTest {

    @isTest
    static void testGetMessage() {

        String result = DeltaAccountService.getMessage();

        System.assertEquals(
            'Delta v2 deployment POC',
            result
        );
    }
}   