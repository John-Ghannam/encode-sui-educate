module car::car_admin {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling: u8
    }

    // Create Admin Capability, you can create more as you need it. 
    struct AdminCapability has key { id: UID }
    
    // called one time as soon the module is published. 
    // We are instantiating admin capability object 
    // we are sending it to the sender 
    // in this case is the person publishing this module. 
    // You will use this a lot in the code. 
    // this will ensure one admin capability exist. 
    fun init(ctx: &mut TxContext){
        transfer::transfer(AdminCapability{
            id: object::new(ctx),            
        }, tx_context::sender(ctx))
    }

    // create a new car
    // the first argument is readonly to reference admin capability, anytime you want to ensure the compiler doesn't throw error
    // prefix with underscore. we are not using the admin capability in this function.
    // Only admin capability can create a car.
    // the rest of the arguments are the car stats.
    public entry fun create(_: &AdminCapability, speed: u8, acceleration: u8, handling: u8, ctx: &mut TxContext) {
        let car = new(speed, acceleration, handling, ctx);
        transfer::transfer(car, tx_context::sender(ctx));
    }





}



