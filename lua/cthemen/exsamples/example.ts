import { randomUUID } from "node:crypto";
import { createInterface } from "node:readline";

interface SUser {
	id: string;
	name: string;
	email: string;
	role: TUserRole;
	createdAt: Date;
	metadata: Record<string, unknown>;
}

type TUserRole = "admin" | "editor" | "viewer";

type TResult<T> =
	| { ok: true; value: T }
	| { ok: false; error: string };

interface IRepository<T> {
	findById(id: string): Promise<T | null>;
	findAll(filter?: Partial<T>): Promise<T[]>;
	create(data: Omit<T, "id" | "createdAt">): Promise<T>;
	update(id: string, data: Partial<T>): Promise<T>;
	delete(id: string): Promise<boolean>;
}

abstract class BaseRepository<T extends { id: string }>
	implements IRepository<T> {
	abstract readonly store: Map<string, T>;

	async findById(id: string): Promise<T | null> {
		return this.store.get(id) ?? null;
	}

	async findAll(filter?: Partial<T>): Promise<T[]> {
		if (!filter) return [...this.store.values()];
		return [...this.store.values()].filter((item) =>
			Object.entries(filter).every(
				([key, val]) => item[key as keyof T] === val,
			),
		);
	}

	abstract create(data: Omit<T, "id" | "createdAt">): Promise<T>;
	abstract update(id: string, data: Partial<T>): Promise<T>;
	abstract delete(id: string): Promise<boolean>;
}

class UserRepository extends BaseRepository<SUser> {
	readonly store: Map<string, SUser> = new Map();

	async create(data: Omit<SUser, "id" | "createdAt">): Promise<SUser> {
		const user: SUser = {
			id: randomUUID(),
			...data,
			createdAt: new Date(),
		};
		this.store.set(user.id, user);
		return user;
	}

	async update(id: string, data: Partial<SUser>): Promise<SUser> {
		const existing = await this.findById(id);
		if (!existing) throw new Error(`user ${id} not found`);
		const updated = { ...existing, ...data };
		this.store.set(id, updated);
		return updated;
	}

	async delete(id: string): Promise<boolean> {
		return this.store.delete(id);
	}
}

async function* paginate<T>(
	items: T[],
	pageSize: number = 10,
): AsyncGenerator<T[], void> {
	for (let i = 0; i < items.length; i += pageSize) {
		yield items.slice(i, i + pageSize);
	}
}

const guard = <T>(value: unknown, key: string): value is Record<string, T> =>
	typeof value === "object" && value !== null && key in value;

const pipe =
	<T>(...fns: Array<(arg: T) => T>) =>
		(x: T): T =>
			fns.reduce((acc, fn) => fn(acc), x);

function assertNonNull<T>(value: T, msg?: string): asserts value is NonNullable<T> {
	if (value == null) throw new Error(msg ?? "unexpected null");
}

const repo = new UserRepository();
const decoder = new TextDecoder();
const encoder = new TextEncoder();

async function handleQuery(q: string): Promise<TResult<SUser[]>> {
	const trimmed = q.trim().toLowerCase();
	if (!trimmed) return { ok: false, error: "empty query" };

	try {
		const all = await repo.findAll();
		const filtered = all.filter(
			(u) =>
				u.name.toLowerCase().includes(trimmed) ||
				u.email.toLowerCase().includes(trimmed),
		);
		return { ok: true, value: filtered };
	} catch (err) {
		return { ok: false, error: String(err) };
	}
}

const rl = createInterface({ input: process.stdin, output: process.stdout });
rl.on("line", async (line: string) => {
	const result = await handleQuery(line);
	if (result.ok) {
		console.table(result.value);
	} else {
		console.error(`error: ${result.error}`);
	}
});

export type { SUser, TUserRole, TResult, IRepository };
export { BaseRepository, UserRepository, paginate, guard, pipe, assertNonNull };
