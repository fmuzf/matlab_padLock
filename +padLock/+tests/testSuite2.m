function test_suite = testSuite2()
initTestSuite;
end


function goldpath = setup()
goldpath = padLock.tests.getDataPath();
end


function teardown(goldpath)
end


function testReadStatus(goldpath)
goldfile = [goldpath '/locked.gold'];
stats = @(x)padLock.tests.StatusCodes(x);

genStatus = padLock.getLockStatus(goldfile, stats);
assertEqual(padLock.tests.StatusCodes.LOCKED, genStatus);
end


function testReadBadStatus(goldpath)
goldfile = [goldpath '/undefined.gold'];
stats = @(x)padLock.tests.StatusCodes(x);

f = @()padLock.getLockStatus(goldfile, stats);
assertExceptionThrown(f,'MATLAB:class:InvalidEnum');
end