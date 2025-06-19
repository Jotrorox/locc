<script lang="ts">
	let copied = false;
	
	const copyToClipboard = async (text: string) => {
		try {
			await navigator.clipboard.writeText(text);
			copied = true;
			setTimeout(() => {
				copied = false;
			}, 2000);
		} catch (err) {
			console.error('Failed to copy: ', err);
		}
	};
</script>

<section id="installation" class="py-20 bg-gray-50 dark:bg-gray-900">
	<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
		<div class="text-center mb-16">
			<h2 class="text-4xl font-bold text-gray-900 dark:text-white mb-4">
				Get Started in Seconds
			</h2>
			<p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
				Choose your preferred installation method and start analyzing your code right away.
			</p>
		</div>
		
		<div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
			<!-- From Source -->
			<div class="p-8 rounded-2xl bg-white dark:bg-gray-800 shadow-lg border border-gray-200 dark:border-gray-700">
				<div class="flex items-center mb-6">
					<div class="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center mr-4">
						<span class="text-white text-lg">🛠️</span>
					</div>
					<h3 class="text-2xl font-semibold text-gray-900 dark:text-white">
						Build from Source
					</h3>
				</div>
				
				<p class="text-gray-600 dark:text-gray-300 mb-6">
					Clone the repository and build with Zig for the latest features and optimizations.
				</p>
				
				<div class="bg-gray-900 rounded-lg p-4 font-mono text-sm relative">
					<button
						on:click={() => copyToClipboard('git clone https://github.com/jotrorox/locc.git\ncd locc\nzig build --release=small')}
						class="absolute top-2 right-2 p-2 text-gray-400 hover:text-white transition-colors"
						title="Copy to clipboard"
					>
						{#if copied}
							<span class="text-green-400">✓</span>
						{:else}
							📋
						{/if}
					</button>
					
					<div class="text-green-400">$ git clone https://github.com/jotrorox/locc.git</div>
					<div class="text-green-400">$ cd locc</div>
					<div class="text-green-400">$ zig build --release=small</div>
				</div>
			</div>
			
			<!-- Pre-built Binaries -->
			<div class="p-8 rounded-2xl bg-white dark:bg-gray-800 shadow-lg border border-gray-200 dark:border-gray-700">
				<div class="flex items-center mb-6">
					<div class="w-10 h-10 bg-green-500 rounded-lg flex items-center justify-center mr-4">
						<span class="text-white text-lg">📦</span>
					</div>
					<h3 class="text-2xl font-semibold text-gray-900 dark:text-white">
						Pre-built Binaries
					</h3>
				</div>
				
				<p class="text-gray-600 dark:text-gray-300 mb-6">
					Download ready-to-use binaries for your platform from the releases page.
				</p>
				
				<a
					href="https://github.com/jotrorox/locc/releases"
					target="_blank"
					rel="noopener noreferrer"
					class="inline-flex items-center justify-center w-full px-6 py-3 bg-green-500 hover:bg-green-600 text-white font-semibold rounded-lg transition-colors"
				>
					<span class="mr-2">⬇️</span>
					Download Latest Release
				</a>
			</div>
		</div>
		
		<!-- Quick Usage -->
		<div class="p-8 rounded-2xl bg-gradient-to-r from-blue-600 to-purple-600 text-white">
			<h3 class="text-2xl font-bold mb-6 text-center">
				Quick Usage Examples
			</h3>
			
			<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
				<div class="bg-black/20 rounded-lg p-4 backdrop-blur-sm">
					<h4 class="text-lg font-semibold mb-2">📊 Basic Analysis</h4>
					<div class="font-mono text-sm bg-gray-900 rounded p-3">
						<div class="text-green-400">$ locc</div>
						<div class="text-gray-300 text-xs mt-1">Count lines in current directory</div>
					</div>
				</div>
				
				<div class="bg-black/20 rounded-lg p-4 backdrop-blur-sm">
					<h4 class="text-lg font-semibold mb-2">📁 Specific Directory</h4>
					<div class="font-mono text-sm bg-gray-900 rounded p-3">
						<div class="text-green-400">$ locc /path/to/project</div>
						<div class="text-gray-300 text-xs mt-1">Analyze specific project</div>
					</div>
				</div>
				
				<div class="bg-black/20 rounded-lg p-4 backdrop-blur-sm">
					<h4 class="text-lg font-semibold mb-2">🔍 File Filtering</h4>
					<div class="font-mono text-sm bg-gray-900 rounded p-3">
						<div class="text-green-400">$ locc -r "*.js"</div>
						<div class="text-gray-300 text-xs mt-1">Count only JavaScript files</div>
					</div>
				</div>
				
				<div class="bg-black/20 rounded-lg p-4 backdrop-blur-sm">
					<h4 class="text-lg font-semibold mb-2">📈 File Mode</h4>
					<div class="font-mono text-sm bg-gray-900 rounded p-3">
						<div class="text-green-400">$ locc --file-mode</div>
						<div class="text-gray-300 text-xs mt-1">Show detailed file statistics</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
