<svelte:head>
	<title>Usage - LOCC Documentation</title>
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		Usage Guide
	</h1>
	
	<p class="text-xl text-gray-600 dark:text-gray-300 mb-8">
		Learn how to use LOCC effectively with all its features and command-line options.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Basic Usage
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		The simplest way to use LOCC is to run it in your project directory:
	</p>
	
	<div class="bg-gray-900 rounded-lg p-6 mb-6">
		<div class="text-green-400 font-mono text-sm mb-2"># Count lines in current directory</div>
		<div class="text-white font-mono text-sm">locc</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Count lines in specific directory</div>
		<div class="text-white font-mono text-sm">locc /path/to/your/project</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Command-Line Options
	</h2>
	
	<div class="space-y-6">
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--file-mode</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-f</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Show file count grouped by type instead of line count.
			</p>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-white font-mono text-sm">locc --file-mode</div>
				<div class="text-white font-mono text-sm">locc -f /path/to/project</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--regex</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-r</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Filter files using wildcard patterns. Supports <code>*</code> (any characters) and <code>?</code> (single character).
			</p>
			<div class="bg-gray-900 rounded p-4 space-y-2">
				<div class="text-green-400 font-mono text-sm"># Count only JavaScript files</div>
				<div class="text-white font-mono text-sm">locc -r "*.js"</div>
				
				<div class="text-green-400 font-mono text-sm"># Count only test files</div>
				<div class="text-white font-mono text-sm">locc -r "test*"</div>
				
				<div class="text-green-400 font-mono text-sm"># Count Zig files with single character extension</div>
				<div class="text-white font-mono text-sm">locc -r "*.zi?"</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--help</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-h</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Show help information and usage examples.
			</p>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-white font-mono text-sm">locc --help</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--version</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-v</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Display the current version of LOCC.
			</p>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-white font-mono text-sm">locc --version</div>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Pattern Matching
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		LOCC supports powerful pattern matching with wildcards for precise file filtering:
	</p>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-6">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Wildcard Patterns</h3>
		<ul class="space-y-2 text-gray-600 dark:text-gray-300">
			<li><code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">*</code> - Matches any sequence of characters (including none)</li>
			<li><code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">?</code> - Matches any single character</li>
		</ul>
	</div>
	
	<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
		<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4">
			<h4 class="font-semibold text-blue-900 dark:text-blue-100 mb-2">Web Development</h4>
			<div class="space-y-1 text-sm font-mono">
				<div class="text-blue-800 dark:text-blue-200">locc -r "*.js"</div>
				<div class="text-blue-800 dark:text-blue-200">locc -r "*.ts"</div>
				<div class="text-blue-800 dark:text-blue-200">locc -r "*.vue"</div>
				<div class="text-blue-800 dark:text-blue-200">locc -r "*component*"</div>
			</div>
		</div>
		
		<div class="bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg p-4">
			<h4 class="font-semibold text-green-900 dark:text-green-100 mb-2">Systems Programming</h4>
			<div class="space-y-1 text-sm font-mono">
				<div class="text-green-800 dark:text-green-200">locc -r "*.c"</div>
				<div class="text-green-800 dark:text-green-200">locc -r "*.cpp"</div>
				<div class="text-green-800 dark:text-green-200">locc -r "*.rs"</div>
				<div class="text-green-800 dark:text-green-200">locc -r "*.zig"</div>
			</div>
		</div>
		
		<div class="bg-purple-50 dark:bg-purple-900/20 border border-purple-200 dark:border-purple-800 rounded-lg p-4">
			<h4 class="font-semibold text-purple-900 dark:text-purple-100 mb-2">Testing</h4>
			<div class="space-y-1 text-sm font-mono">
				<div class="text-purple-800 dark:text-purple-200">locc -r "test*"</div>
				<div class="text-purple-800 dark:text-purple-200">locc -r "*test*"</div>
				<div class="text-purple-800 dark:text-purple-200">locc -r "*.test.js"</div>
				<div class="text-purple-800 dark:text-purple-200">locc -r "*spec*"</div>
			</div>
		</div>
		
		<div class="bg-orange-50 dark:bg-orange-900/20 border border-orange-200 dark:border-orange-800 rounded-lg p-4">
			<h4 class="font-semibold text-orange-900 dark:text-orange-100 mb-2">Documentation</h4>
			<div class="space-y-1 text-sm font-mono">
				<div class="text-orange-800 dark:text-orange-200">locc -r "*.md"</div>
				<div class="text-orange-800 dark:text-orange-200">locc -r "README*"</div>
				<div class="text-orange-800 dark:text-orange-200">locc -r "doc*"</div>
				<div class="text-orange-800 dark:text-orange-200">locc -r "*.txt"</div>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Combining Options
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-4">
		You can combine different options for more sophisticated analysis:
	</p>
	
	<div class="bg-gray-900 rounded-lg p-6 mb-6">
		<div class="text-green-400 font-mono text-sm mb-2"># Show file count for only Python files</div>
		<div class="text-white font-mono text-sm">locc --file-mode --regex "*.py" /path/to/project</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Short form</div>
		<div class="text-white font-mono text-sm">locc -f -r "*.py" /path/to/project</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Understanding Output
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-6">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">Line Count Mode (Default)</h3>
		<div class="bg-gray-900 rounded p-4 font-mono text-sm">
			<div class="text-blue-400">📁 Analyzing /path/to/project...</div>
			<div class="text-purple-400">🔥 TypeScript    1,234 lines</div>
			<div class="text-yellow-400">⚡ JavaScript      856 lines</div>
			<div class="text-red-400">🎨 CSS            432 lines</div>
			<div class="text-green-400">📝 HTML           198 lines</div>
			<div class="text-cyan-400 border-t border-gray-600 pt-2 mt-2">✨ Total: 2,720 lines of code</div>
		</div>
	</div>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">File Count Mode</h3>
		<div class="bg-gray-900 rounded p-4 font-mono text-sm">
			<div class="text-blue-400">📁 Analyzing /path/to/project...</div>
			<div class="text-purple-400">🔥 TypeScript     12 files</div>
			<div class="text-yellow-400">⚡ JavaScript      8 files</div>
			<div class="text-red-400">🎨 CSS             3 files</div>
			<div class="text-green-400">📝 HTML            2 files</div>
			<div class="text-cyan-400 border-t border-gray-600 pt-2 mt-2">✨ Total: 25 files</div>
		</div>
	</div>
	
	<div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-6">
		<h3 class="text-lg font-semibold text-yellow-900 dark:text-yellow-100 mb-2">
			💡 Pro Tips
		</h3>
		<ul class="text-yellow-800 dark:text-yellow-200 space-y-2">
			<li>• Use patterns to focus on specific parts of your codebase</li>
			<li>• Combine with file mode to understand project structure</li>
			<li>• LOCC automatically ignores common build directories and files</li>
			<li>• Colors help quickly identify the dominant languages in your project</li>
		</ul>
	</div>
</div>
