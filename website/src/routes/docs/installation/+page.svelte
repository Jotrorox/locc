<svelte:head>
	<title>Installation - LOCC Documentation</title>
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		Installation
	</h1>
	
	<p class="text-xl text-gray-600 dark:text-gray-300 mb-8">
		Get LOCC up and running on your system with these simple installation methods.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Prerequisites
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-6">
		To build LOCC from source, you'll need:
	</p>
	
	<ul class="list-disc list-inside text-gray-600 dark:text-gray-300 mb-8 space-y-2">
		<li><strong>Zig</strong> - Version 0.11.0 or later (<a href="https://ziglang.org/download/" target="_blank" rel="noopener noreferrer" class="text-blue-600 dark:text-blue-400 hover:underline">Download Zig</a>)</li>
		<li><strong>Git</strong> - For cloning the repository</li>
	</ul>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Method 1: Build from Source
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		Building from source gives you the latest features and allows you to customize the build process.
	</p>
	
	<div class="bg-gray-900 rounded-lg p-6 mb-6">
		<div class="text-green-400 font-mono text-sm mb-2"># Clone the repository</div>
		<div class="text-white font-mono text-sm">git clone https://github.com/jotrorox/locc.git</div>
		<div class="text-white font-mono text-sm">cd locc</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Build the project</div>
		<div class="text-white font-mono text-sm">zig build --release=small</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># The binary will be available at:</div>
		<div class="text-white font-mono text-sm">./zig-out/bin/locc</div>
	</div>
	
	<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-blue-900 dark:text-blue-100 mb-2">
			💡 Pro Tip
		</h3>
		<p class="text-blue-800 dark:text-blue-200">
			You can add the binary to your PATH for global access: <code class="bg-blue-100 dark:bg-blue-800 px-2 py-1 rounded">export PATH=$PATH:$(pwd)/zig-out/bin</code>
		</p>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Method 2: Pre-built Binaries
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		Download ready-to-use binaries from the GitHub releases page.
	</p>
	
	<div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
		<div class="p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🐧 Linux</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm mb-3">
				Compatible with most Linux distributions
			</p>
			<a href="https://github.com/jotrorox/locc/releases" target="_blank" rel="noopener noreferrer" class="text-blue-600 dark:text-blue-400 hover:underline text-sm font-medium">
				Download for Linux →
			</a>
		</div>
		
		<div class="p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🍎 macOS</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm mb-3">
				Universal binary for Intel and Apple Silicon
			</p>
			<a href="https://github.com/jotrorox/locc/releases" target="_blank" rel="noopener noreferrer" class="text-blue-600 dark:text-blue-400 hover:underline text-sm font-medium">
				Download for macOS →
			</a>
		</div>
		
		<div class="p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🪟 Windows</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm mb-3">
				Native Windows executable
			</p>
			<a href="https://github.com/jotrorox/locc/releases" target="_blank" rel="noopener noreferrer" class="text-blue-600 dark:text-blue-400 hover:underline text-sm font-medium">
				Download for Windows →
			</a>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Verify Installation
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		After installation, verify that LOCC is working correctly:
	</p>
	
	<div class="bg-gray-900 rounded-lg p-6 mb-6">
		<div class="text-green-400 font-mono text-sm mb-2"># Check version</div>
		<div class="text-white font-mono text-sm">locc --version</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Run help command</div>
		<div class="text-white font-mono text-sm">locc --help</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Test on current directory</div>
		<div class="text-white font-mono text-sm">locc .</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Troubleshooting
	</h2>
	
	<div class="space-y-6">
		<div class="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-red-900 dark:text-red-100 mb-2">
				Command not found
			</h3>
			<p class="text-red-800 dark:text-red-200 mb-2">
				If you get "command not found" error, make sure the binary is in your PATH or use the full path to the executable.
			</p>
			<div class="bg-red-100 dark:bg-red-800 rounded p-2 font-mono text-sm text-red-900 dark:text-red-100">
				# Add to PATH (Linux/macOS)<br/>
				export PATH=$PATH:/path/to/locc/zig-out/bin
			</div>
		</div>
		
		<div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-yellow-900 dark:text-yellow-100 mb-2">
				Permission denied
			</h3>
			<p class="text-yellow-800 dark:text-yellow-200 mb-2">
				On Unix-like systems, make sure the binary has execute permissions:
			</p>
			<div class="bg-yellow-100 dark:bg-yellow-800 rounded p-2 font-mono text-sm text-yellow-900 dark:text-yellow-100">
				chmod +x /path/to/locc
			</div>
		</div>
	</div>
	
	<div class="mt-8 p-6 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg">
		<h3 class="text-lg font-semibold text-green-900 dark:text-green-100 mb-2">
			✅ Next Steps
		</h3>
		<p class="text-green-800 dark:text-green-200 mb-4">
			Now that LOCC is installed, check out the usage guide to learn how to make the most of it!
		</p>
		<a href="/docs/usage" class="inline-flex items-center text-green-600 dark:text-green-400 hover:text-green-800 dark:hover:text-green-200 font-medium">
			Learn Usage →
		</a>
	</div>
</div>
