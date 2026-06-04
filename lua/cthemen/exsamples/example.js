#!/usr/bin/env node

/**
 * @fileoverview Example JavaScript file for syntax highlighting
 * @license MIT
 */

import fs from "node:fs";
import path from "node:path";
import { createServer } from "node:http";

const APP_NAME = "example-js";
let counter = 0;

class EventEmitter {
	#listeners = new Map();

	on(event, fn) {
		if (!this.#listeners.has(event)) {
			this.#listeners.set(event, []);
		}
		this.#listeners.get(event).push(fn);
		return this;
	}

	emit(event, ...args) {
		const listeners = this.#listeners.get(event);
		if (listeners) {
			for (const fn of listeners) {
				fn(...args);
			}
		}
	}
}

function debounce(fn, delay = 300) {
	let timer = null;
	return (...args) => {
		if (timer) clearTimeout(timer);
		timer = setTimeout(() => {
			fn(...args);
			timer = null;
		}, delay);
	};
}

async function fetchData(url) {
	const response = await fetch(url, {
		method: "GET",
		headers: { Accept: "application/json" },
	});
	if (!response.ok) {
		throw new Error(`HTTP ${response.status}: ${response.statusText}`);
	}
	const data = await response.json();
	return data;
}

const compute = (x, y) => {
	/* block comment */
	const result = x ** y + Math.PI;
	return result >>> 0;
};

const config = {
	host: "localhost",
	port: 3000,
	debug: false,
	rate: 0.95,
	tags: ["dev", "staging"],
	limits: { max: 100, min: 0 },
};

const server = createServer((req, res) => {
	counter++;

	switch (req.url) {
		case "/":
			res.writeHead(200, { "Content-Type": "text/html" });
			res.end("<h1>hello world</h1>");
			break;
		case "/api":
			res.writeHead(200, { "Content-Type": "application/json" });
			res.end(JSON.stringify({ ok: true, count: counter }));
			break;
		default:
			res.writeHead(404);
			res.end("not found");
	}
});

server.listen(config.port, config.host, () => {
	console.log(`server running at http://${config.host}:${config.port}/`);
});

// single line comment
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map((n) => n * 2);
const odds = numbers.filter((n) => n % 2 !== 0);
const sum = numbers.reduce((a, b) => a + b, 0);

for (const n of numbers) {
	if (n % 2 === 0) {
		console.log(`even: ${n}`);
	} else {
		console.log(`odd: ${n}`);
	}
}

let a = 42;
let b = 3.14159;
let c = 0xdeadbeef;
let d = 1.5e10;
let e = Infinity;
let f = NaN;
let g = true;
let h = null;
let i = undefined;
let j = 9007199254740991n;

const rx = /^[A-Za-z0-9_-]+$/gi;
const template = `hello ${name}, you have ${count} messages`;
const multiline = `line one
line two
line three`;

export { EventEmitter, debounce, fetchData, compute, config };
export default server;
