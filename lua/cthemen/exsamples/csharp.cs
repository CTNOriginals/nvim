using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Cthemen.Examples
{
	public enum TUserRole
	{
		Admin,
		Editor,
		Viewer
	}

	public record SUserDto {
		[JsonPropertyName("id")]
		public Guid Id { get; init; }

		[JsonPropertyName("name")]
		public string Name { get; init; } = string.Empty;

		[JsonPropertyName("email")]
		public string Email { get; init; } = string.Empty;

		[JsonPropertyName("role")]
		public TUserRole Role { get; init; } = TUserRole.Viewer;

		[JsonPropertyName("score")]
		public double Score { get; init; }

		[JsonPropertyName("tags")]
		public List<string> Tags { get; init; } = new();
	}

	public interface IRepository<T> where T : class {
		Task<T?> GetByIdAsync(Guid id);
		Task<IReadOnlyList<T>> GetAllAsync();
		Task<T> CreateAsync(T entity);
		Task<T> UpdateAsync(T entity);
		Task<bool> DeleteAsync(Guid id);
	}

	public abstract class SBaseRepository<T> : IRepository<T> where T : class {
		protected readonly Dictionary<Guid, T> Store = new();

		public virtual Task<T?> GetByIdAsync(Guid id) {
			return Task.FromResult(Store.TryGetValue(id, out var item) ? item : null);
		}

		public virtual Task<IReadOnlyList<T>> GetAllAsync() {
			return Task.FromResult<IReadOnlyList<T>>(Store.Values.ToList());
		}

		public abstract Task<T> CreateAsync(T entity);
		public abstract Task<T> UpdateAsync(T entity);
		public abstract Task<bool> DeleteAsync(Guid id);
	}

	public sealed class SUserRepository : SBaseRepository<SUserDto> {
		public override async Task<SUserDto> CreateAsync(SUserDto entity) {
			var id = Guid.NewGuid();
			var user = entity with { Id = id };
			Store[id] = user;
			return await Task.FromResult(user);
		}

		public override async Task<SUserDto> UpdateAsync(SUserDto entity) {
			if (!Store.ContainsKey(entity.Id)) {
				throw new KeyNotFoundException($"user {entity.Id} not found");
			}
			Store[entity.Id] = entity;
			return await Task.FromResult(entity);
		}

		public override Task<bool> DeleteAsync(Guid id) {
			return Task.FromResult(Store.Remove(id));
		}
	}

	public static class SUserExtensions
	{
		public static bool IsActive(this SUserDto user, DateTime? since = null)
		{
			since ??= DateTime.UtcNow.AddDays(-30);
			return user.Score > 0.5 && user.Role != TUserRole.Viewer;
		}

		public static string ToJson(this SUserDto user)
		{
			var options = new JsonSerializerOptions
			{
				WriteIndented = true,
				PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
			};
			return JsonSerializer.Serialize(user, options);
		}
	}

	public class SProgram
	{
		private const string AppName = "cthemen-demo";
		private static readonly double Threshold = 0.75;

		// single-line comment
		static async Task Main(string[] args)
		{
			var repo = new SUserRepository();

			var users = new List<SUserDto>
			{
				new()
				{
					Name = "Alice",
					Email = "alice@example.com",
					Role = TUserRole.Admin,
					Score = 0.95,
					Tags = new() { "dev", "lead" },
				},
				new()
				{
					Name = "Bob",
					Email = "bob@example.com",
					Role = TUserRole.Editor,
					Score = 0.45,
					Tags = new() { "docs" },
				},
			};

			var created = new List<SUserDto>();
			foreach (var user in users)
			{
				var result = await repo.CreateAsync(user);
				created.Add(result);
				Console.WriteLine($"created: {result.Name} [{result.Id}]");
			}

			var active = created
				.Where(u => u.IsActive())
				.OrderByDescending(u => u.Score)
				.Select(u => u.ToJson());

			Console.WriteLine($"active users ({active.Count()}):");
			foreach (var json in active)
			{
				Console.WriteLine(json);
			}

			var all = await repo.GetAllAsync();
			Console.WriteLine($"total: {all.Count}");

			var dict = all.ToDictionary(u => u.Id);
			foreach (var (id, user) in dict)
			{
				Console.WriteLine($"{id:N}: {user.Name} <{user.Email}>");
			}

			int n = 42;
			long big = 1_000_000_000L;
			float pi = 3.14159f;
			double e = 2.71828;
			decimal price = 19.99m;
			byte b = 0xFF;
			bool debug = false;
			char letter = 'A';
			string raw = @"c:\Users\demo\file.txt";
			string interpolated = $"hello {user.Name}, score: {user.Score:P}";
			string verbatim = $@"select * from users where id = {id}";
		}
	}
}
