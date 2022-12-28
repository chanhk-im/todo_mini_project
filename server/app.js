// use express for json file and mysql for db
const express = require("express");
const mysql = require("mysql2/promise");
let db = null;
const app = express();

app.use(express.json());

app.post("/create-todo", async (req, res, next) => {
    const todo = req.body.todo;
    console.log(req.body);
    try {
        await db.query("INSERT INTO todos (todo) VALUES (?);", [todo]);
    } catch (e) {
        console.log(e);
    }
    res.json({ status: "OK" });
    next();
});

app.get("/todos", async (req, res, next) => {
    const [rows] = await db.query("SELECT * FROM todos;");

    res.json(rows);
    console.log(rows);
    next();
});

app.put("/update-todo", async (req, res, next) => {
    const id = req.body.id;
    const todo = req.body.todo;
    try {
        await db.query("UPDATE todos SET todo = (?) WHERE id = (?);", [
            todo,
            id,
        ]);
    } catch (e) {
        console.log(e);
    }

    res.json({ status: "OK" });
    console.log(res);
    next();
});

app.delete("/delete-todo/:id", async (req, res, next) => {
    const id = req.params.id;
    try {
        await db.query("DELETE FROM todos WHERE id = (?)", [id]);
    } catch (e) {
        console.log(e);
    }

    res.json({ status: "OK" });
    console.log(res);
    next();
});

// Asynchrony process
async function main() {
    try {
        db = await mysql.createConnection({
            host: "127.0.0.1",
            user: "root",
            password: "root",
            database: "flutter_test",
        });
    } catch (e) {
        console.log(e);
    }

    app.listen(8000);
}

main();
