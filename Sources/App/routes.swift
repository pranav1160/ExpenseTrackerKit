import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: AccountsController())
    try app.register(collection: CategoryController())
    try app.register(collection: ExpenseController())
    try app.register(collection: IncomeController())
    
}
