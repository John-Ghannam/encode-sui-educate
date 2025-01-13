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




}


/*
/// Module: car
module car::car;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


