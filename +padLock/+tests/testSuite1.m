function test_suite = testSuite1()
initTestSuite;
end


function lockfilename = setup()
goldpath = padLock.tests.getDataPath();
lockfilename = [goldpath '/LockCreation.test'];
end


function teardown(lockfilename)
delete(lockfilename);
end


function testLockCreation(lockfilename)
% Test that Lockfile is Created
stats = @(x)padLock.tests.StatusCodes(x);
lf = padLock.LockFile(lockfilename, stats);
lf.setStatus(padLock.tests.StatusCodes.LOCKED);
assertTrue(logical(exist(lockfilename, 'file')));
end


function testLockNoCreation(lockfilename)
% Test that No file is created on construction
stats = @(x)padLock.tests.StatusCodes(x);
lf = padLock.LockFile(lockfilename, stats);
assertFalse(logical(exist(lockfilename, 'file')));
end


function testDelete(lockfilename)
% Test that file is deleted by deleteLock
stats = @(x)padLock.tests.StatusCodes(x);
lf = padLock.LockFile(lockfilename, stats);
lf.setStatus(0);
lf.deleteLock();
assertFalse(logical(exist(lockfilename, 'file')));
end


function testLocksToLocked(lockfilename)
% check that correct file is created
goldpath = padLock.tests.getDataPath();
goldfile = [goldpath '/locked.gold'];

stats = @(x)padLock.tests.StatusCodes(x);
lf = padLock.LockFile(lockfilename, stats);
lf.setStatus(padLock.tests.StatusCodes.LOCKED);

gen = fileread(lockfilename);
gold = fileread(goldfile);
assertEqual(gen, gold);
end


function testUndefinedLockCode(lockfilename)
% check that correct file is created
goldpath = padLock.tests.getDataPath();
goldfile = [goldpath '/locked.gold'];

stats = @(x)padLock.tests.StatusCodes(x);
lf = padLock.LockFile(lockfilename, stats);
lf.setStatus(padLock.tests.StatusCodes.LOCKED);
end

