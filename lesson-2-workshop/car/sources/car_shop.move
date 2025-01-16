module car::car_shop {

    use sui::transfer;
    use sui::sui::SUI;
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID};
    use sui::balance::{Self, Balance};
    use sui::tx_context::{Self, TxContext};

    const EInsufficientBalance: u64 = 0;

    struct Car has key {
        id: UID,
        speed: u8,
        acceleration: u8,
        handling: u8
    }

    struct CarShop has key {
        id: UID,
        price: u64,
        balance: Balance<SUI>
    }

    struct ShopOwnerCap has key { id: UID }

    // init function instead of Admin capability we are calling it Shop Owner capability
    // instantiates it and transfers to the module publisher. 
    // instantiates new car object. 
    // it has id continue object, the price of the car and the balance (which is instantiate at zero)
    fun init (ctx: &mut TxContext) {
        transfer::transfer(ShopOwnerCap {
            id: object::new(ctx)
        }, tx_context::sender(ctx));

        transfer::share_object(CarShop {
            id: object::new(ctx),
            price: 100,
            balance: balance::zero()
        })
    }


    // buy_car function, it takes the shop, payment and context as arguments.
    // it takes in a mutable reference to the car shop ultimately increasing its balance. 
    // increasing the balance, it takes a mutable reference to the payment so that's going to be the number of SUI in your wallet. 
    // Again the transaction context is passed in.
    // simple assertion on the first line. 
    public entry fun buy_car(shop: &mut CarShop, payment: &mut Coin<SUI>, ctx: &mut TxContext) {
        assert!(coin::value(payment) >= shop.price, EInsufficientBalance);

        let coin_balance = coin::balance_mut(payment);
        let paid = balance::split(coin_balance, shop.price);

        balance::join(&mut shop.balance, paid);

        transfer::transfer(Car {
            id: object::new(ctx),
            speed: 50,
            acceleration: 50,
            handling: 50
        }, tx_context::sender(ctx))
    }    


}