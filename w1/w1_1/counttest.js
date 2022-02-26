var Counter = artifacts.require("Counter");

contract("Counter", async accounts => {
    it ('should pass', async() => {
        let counter = await Counter.deployed();
        await counter.count();    
        let value = await counter.counter();
    
        console.log("current counter value:" + value);
        assert.equal(value, 1);
    });
    it ('should fail', async() => {
        let counter = await Counter.deployed();
        await counter.count();    
        let value = await counter.counter();
    
        console.log("current counter value:" + value);
        assert.equal(value, 1);
    });
});