<script lang="ts">
	import { page } from '$app/stores';
	
	const navItems = [
		{ href: '/docs', label: 'Getting Started' },
		{ href: '/docs/installation', label: 'Installation' },
		{ href: '/docs/usage', label: 'Usage' },
		{ href: '/docs/configuration', label: 'Configuration' },
		{ href: '/docs/examples', label: 'Examples' },
		{ href: '/docs/api', label: 'API Reference' }
	];
</script>

<div class="min-h-screen bg-white">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
		<div class="flex flex-col lg:flex-row gap-8">
			<!-- Sidebar -->
			<aside class="lg:w-1/4">
				<nav class="sticky top-8">
					<h2 class="text-lg font-semibold text-gray-900 mb-4">Documentation</h2>
					<ul class="space-y-2">
						{#each navItems as item}
							<li>
								<a
									href={item.href}
									class="block px-3 py-2 rounded-md text-sm transition-colors {$page.url.pathname === item.href
										? 'bg-blue-100 text-blue-700 font-medium'
										: 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'}"
								>
									{item.label}
								</a>
							</li>
						{/each}
					</ul>
				</nav>
			</aside>

			<!-- Main content -->
			<main class="lg:w-3/4">
				<div class="prose prose-blue max-w-none">
					<slot />
				</div>
			</main>
		</div>
	</div>
</div>