// module refers to the fact that is a smart contract 
// the first car is the package name
// the second car name is this particular module name
module car::car {

    // Importing object from sui standard library which will allow instantiate and manipulate objects.
    use sui::object::{Self, UID};
    
    // This is used for instanstiating a new object
    // use is for import essentially doing TxContext (called Transaction Context) is a priviliged object essentially giving us information about the transaction 
    // that we are currently executing, this is done under the hood, 
    // the takeway any time you want to instantiate new object you need to pass in immutable reference to this 
    // transaction context (TxContext), which will generate information about the transaction including the UID 
    use sui::tx_context::{Self, TxContext};
    
    
    // Transfer this to the address calling this function. 
    use sui::transfer; 


    // has key annotation it allows us to write this variable to the blockchain sui network. it will essentially say this car will exist on the sui network in some capacity. 
    // besides key there are 3 other fields: store, copy and drop
    // store: you will be able to store this variable to struct inside another object, for example: struct Car has key, store  
    // this means this car can live independently on the sui blockchain network and it can also exist inside another object as well. 
    // copy and drop: refer to the fact that you can duplicate/delete that struct respectfully.
    struct Car has key {
        id: UID, 
        speed: u8,
        acceleration: u8,
        handling: u8
    }


    // visibility modifiers to the functions for example: public means anyone can import to another module 
    // public friend function means modules with specific permissions. 
    // entry functions can be called directly. entry functions cannot return anything, entry fun new
    fun new(speed: u8, accelaration: u8, handling: u8, ctx: &mut TxContext): Car {
        Car{
            id: object::new(ctx), 
            speed, 
            acceleration, 
            handling
        }
    }


    // constructors are named new 
    // entry functions are named create. 
    public entry fun create(speed: u8, acceleration: u8, handling: u8, ctx: &mut TxContext){
        let car = new(speed, acceleration, handling, ctx);
        transfer::transfer(car, tx_context::sender(ctx));
    }


    // Let say now we want to transfer or trade in the car to a friend. or listed to a market place
    // public entry function of transfer and pass the car and the address of the recipient. 
    // transfer function by itself is private function for security in sui therefore you want 
    // to create a public transfer function. 
    public entry fun transfer(car: Car, recipient: address){
        transfer::transfer(car, recipient);
    }

    // passing the values as readonly. 
    public fun get_stats(self: &Car): (u8, u8, u8){
        (self.speed, self.handling, self.acceleration)
    }

    // Take your car to modification, take it to body shop 
    // to demonstrate this in sui is 
    // to modify and mutate that pass it as mutable reference.  
    public entry fun upgrade_speed(self: &mut Car, amount: u8){
        self.speed = self.speed + amount;
    }

    public entry fun upgrade_acceleration(self: &mut Car, amount: u8) {
        self.acceleration = self.acceleration + amount;
    }

    public entry fun upgrade_handling(self: &mut Car, amount: u8) {
        self.handling = self.handling + amount;
    }

    // Recap and biggest take away is that
    // Sui utilizes an object-centric programming model
    // Objects represent ownership.
}


/*
/// Module: car
module car::car;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


