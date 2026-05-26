@isTest
private class DeltaAccountServiceTest {

    @isTest
    static void testGetMessage() {

        String result = DeltaAccountServiceTest.getMessage();

        System.assertEquals(
            'Delta v2 deployment POC',
            result
        );
    }
}