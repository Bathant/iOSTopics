struct Vector {
    let x: Int
    let y: Int
    let z: Int
}

extension Vector: ExpressibleByArrayLiteral {
    init(arrayLiteral: Int...) {
        assert(arrayLiteral.count == 3, "Must initialize vector with 3 values.")
        self.x = arrayLiteral[0]
        self.y = arrayLiteral[1]
        self.z = arrayLiteral[2]
    }
}

extension Vector: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y), \(z))"
    }
}

let vectorA: Vector = [1, 3, 2]
let vectorB = [-2, 5, 1] as Vector

extension Vector {
    static func + (_ left: Vector,_ right: Vector )->Vector{
        return [left.x+right.x, left.y+right.y, left.z+right.z]
    }
}
vectorA + vectorB // (-1, 8, 3)
/*:
 ## Other Types of Operators
 
 **infix:** Used between two values, like the addition operator (e.g., 1 + 1).
 
 **prefix:** Added before a value, like the negation operator (e.g., -3).
 
 **postfix:** Added after a value, like the force-unwrap operator (e.g., mayBeNil!).
 
 **ternary:** Two symbols inserted between three values. In Swift, user defined ternary operators are not supported and there is only one built-in ternary operator which you can read about in Apple’s documentation.
 */
/*:
    negative
 */
extension Vector {
static prefix func - (vector: Vector) -> Vector {
    return [-vector.x, -vector.y, -vector.z]
}
}
-vectorA // (-1, -3, -2)
/*:
    subtraction
 */
extension Vector {
static func - (left: Vector, right: Vector) -> Vector {
    return left + -right
}
}
vectorA - vectorB // (3, -2, 1)

/*:
 
    multiplication
 */
extension Vector {
static func * (left: Int, right: Vector) -> Vector {
    return [
        right.x * left,
        right.y * left,
        right.z * left
    ]
}

static func * (left: Vector, right: Int) -> Vector {
    return right * left
}
}
/*:
    Equitablity
 
 */

extension Vector: Equatable {
    static func == (left: Vector, right: Vector) -> Bool {
        return left.x == right.x && left.y == right.y && left.z == right.z
    }
}
vectorA == vectorB // false


/*:
    for the customized new operators that doesn't exist,
    we must declare them first
    for below example it means:
    This defines • as an operator that must be placed between two other values and has the same precedence as the addition operator +
 */
//infix operator •: AdditionPrecedence
//extension Vector{
//static func • (left: Vector, right: Vector) -> Int {
//    return left.x * right.x + left.y * right.y + left.z * right.z
//}
//}
//vectorA • vectorB // 15

/*:
 - - - - - - - - - -
 ![operator precedence](operator_precedence.png)
 */

/*:
 here we will make precedencegroup that is lower than the addation precedence
 we also make it left-associative because you want it evaluated from left-to-right as you do in addition and multiplication. Then you assign this new precedence group to your • operator.
 */
precedencegroup DotProductPrecedence {
    lowerThan: AdditionPrecedence
    associativity: left
}
infix operator •: DotProductPrecedence
extension Vector{
    static func • (left: Vector, right: Vector) -> Int {
        return left.x * right.x + left.y * right.y + left.z * right.z
    }
}
vectorA • vectorB + vectorA // 29

