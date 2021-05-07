import Foundation

@main
struct Eat {
    static func main() async throws {
        let meal = try await makeDinner()
        print(meal)
    }
}

struct Meal {
    let dish: Dish
}

func makeDinner() async throws -> Meal {
    spawn let veggies = try await chopVegetables()
    spawn let meat = await marinateMeat()
    spawn let oven = try await preheatOven(temperature: 350)
    let dish = try await Dish(ingredients: veggies + [meat])
    return try await oven.cook(dish)
}

protocol Ingredient {}

struct Oven {
    func cook(_ dish: Dish) async throws -> Meal {
        sleep(1)
        return Meal(dish: dish)
    }
}

struct Dish {
    let ingredients: [Ingredient]
}

func preheatOven(temperature: UInt) async throws -> Oven {
    print("Preheating")
    sleep(2)
    print("Preheated")
    return Oven()
}

struct Meat: Ingredient {}

func marinateMeat() async -> Meat {
    sleep(1)
    return Meat()
}

func chopVegetables() async throws -> [Vegetable] {
    try await withThrowingTaskGroup(of: Vegetable.self) { group in
        let rawVeggies: [Vegetable] = [
            Vegetable(kind: .broccoli), Vegetable(kind: .carrot), Vegetable(kind: .tomato), Vegetable(kind: .onion)
        ]
        var choppedVeggies: [Vegetable] = []

        for v in rawVeggies {
            group.spawn(priority: .userInitiated) {
                try await v.chopped()
            }
        }

        while let choppedVeggie = try await group.next() {
            choppedVeggies.append(choppedVeggie)
        }

        return choppedVeggies
    }
}

struct Vegetable: Ingredient {
    let kind: Kind
    let isChopped: Bool

    init(kind: Kind, isChopped: Bool = false) {
        self.kind = kind
        self.isChopped = isChopped
    }

    func chopped() async throws -> Vegetable {
        print("Chopping \(kind)")
        sleep(1)
        return Vegetable(kind: kind, isChopped: true)
    }

    enum Kind {
        case tomato, onion, carrot, broccoli
    }
}
