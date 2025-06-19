<script lang="ts">
	import { onMount } from 'svelte';
	
	let mounted = false;
	
	onMount(() => {
		mounted = true;
	});
</script>

<section class="relative overflow-hidden bg-gradient-to-r from-blue-600 via-purple-600 to-indigo-600 text-white">
	<div class="absolute inset-0 bg-black/20"></div>
	
	<!-- Background Pattern -->
	<div class="absolute inset-0 opacity-10">
		<div class="absolute inset-0 bg-dots-white"></div>
	</div>
	
	<div class="relative mx-auto max-w-7xl px-4 py-24 sm:px-6 lg:px-8 lg:py-32">
		<div class="text-center">
			<div class="mb-8 inline-flex items-center rounded-full bg-white/10 px-6 py-2 text-sm font-medium backdrop-blur-sm">
				<span class="mr-2">🚀</span>
				Fast • Beautiful • Multi-language
			</div>
			
			<h1 class="mb-6 text-5xl font-bold tracking-tight sm:text-6xl lg:text-7xl">
				<span class="block">Lines of Code</span>
				<span class="block bg-gradient-to-r from-yellow-400 to-orange-400 bg-clip-text text-transparent">
					Counter
				</span>
			</h1>
			
			<p class="mx-auto mb-10 max-w-2xl text-xl text-gray-200 sm:text-2xl">
				A blazingly fast and beautiful command-line tool for counting lines of code across 
				multiple programming languages with colorful terminal output.
			</p>
			
			<div class="flex flex-col gap-4 sm:flex-row sm:justify-center">
				<a
					href="#installation"
					class="inline-flex items-center justify-center rounded-lg bg-white px-8 py-4 text-lg font-semibold text-gray-900 shadow-lg transition-all hover:bg-gray-100 hover:scale-105"
				>
					<span class="mr-2">⚡</span>
					Get Started
				</a>
				
				<a
					href="/docs"
					class="inline-flex items-center justify-center rounded-lg border-2 border-white/30 px-8 py-4 text-lg font-semibold text-white backdrop-blur-sm transition-all hover:bg-white/10"
				>
					<span class="mr-2">📖</span>
					Documentation
				</a>
				
				<a
					href="https://github.com/jotrorox/locc"
					target="_blank"
					rel="noopener noreferrer"
					class="inline-flex items-center justify-center rounded-lg border-2 border-white/30 px-8 py-4 text-lg font-semibold text-white backdrop-blur-sm transition-all hover:bg-white/10"
				>
					<span class="mr-2">⭐</span>
					GitHub
				</a>
			</div>
		</div>
		
		<!-- Terminal Demo -->
		<div class="mx-auto mt-16 max-w-4xl">
			<div class="rounded-lg bg-gray-900 p-6 shadow-2xl">
				<div class="mb-4 flex items-center gap-2">
					<div class="h-3 w-3 rounded-full bg-red-500"></div>
					<div class="h-3 w-3 rounded-full bg-yellow-500"></div>
					<div class="h-3 w-3 rounded-full bg-green-500"></div>
					<span class="ml-4 text-sm text-gray-400">Terminal</span>
				</div>
				
				<div class="font-mono text-sm">
					<div class="text-green-400">$ locc /path/to/your/project</div>
					<div class="mt-2 text-gray-300">
						<div class="text-blue-400">📁 Analyzing project...</div>
						<div class="mt-2">
							<div class="text-purple-400">🔥 TypeScript    1,234 lines</div>
							<div class="text-yellow-400">⚡ JavaScript      856 lines</div>
							<div class="text-red-400">🎨 CSS            432 lines</div>
							<div class="text-green-400">📝 HTML           198 lines</div>
						</div>
						<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
							✨ Total: 2,720 lines of code
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
