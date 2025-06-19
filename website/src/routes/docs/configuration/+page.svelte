<svelte:head>
	<title>Configuration - LOCC Documentation</title>
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		Configuration
	</h1>
	
	<p class="text-xl text-gray-600 dark:text-gray-300 mb-8">
		LOCC uses an embedded configuration system that determines which files and directories to ignore during analysis.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		How Configuration Works
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-6">
		The configuration is stored in <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">src/config/config.json</code> and is embedded into the binary at compile time using Zig's <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">@embedFile</code> directive. This means the configuration is part of the executable and doesn't require external files.
	</p>
	
	<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4 mb-8">
		<div class="flex">
			<div class="ml-3">
				<p class="text-sm text-blue-800 dark:text-blue-200">
					<strong>Note:</strong> To modify the configuration, you need to edit the source file and rebuild the application with <code>zig build</code>.
				</p>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Configuration Structure
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			Configuration Schema
		</h3>
		<div class="bg-gray-900 rounded p-6 overflow-x-auto">
			<pre class="text-sm text-gray-300"><code>{`{
  "ignored_paths": [
    "directory_name",
    "file_name",
    "*.extension"
  ],
  "file_types": {
    "language_name": ["ext1", "ext2"]
  }
}`}</code></pre>
		</div>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Supported File Types
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-6">
		LOCC recognizes over 40 programming languages through file extensions including JavaScript, TypeScript, Python, Rust, Go, Zig, and many more.
	</p>

	<div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-6">
		<h3 class="text-lg font-semibold text-yellow-900 dark:text-yellow-100 mb-4">
			📝 Customizing Configuration
		</h3>
		<ol class="text-yellow-800 dark:text-yellow-200 space-y-2 list-decimal list-inside">
			<li>Edit <code class="bg-yellow-100 dark:bg-yellow-800 px-2 py-1 rounded">src/config/config.json</code></li>
			<li>Add or remove entries from the <code class="bg-yellow-100 dark:bg-yellow-800 px-2 py-1 rounded">ignored_paths</code> array</li>
			<li>Rebuild the application with <code class="bg-yellow-100 dark:bg-yellow-800 px-2 py-1 rounded">zig build</code></li>
		</ol>
	</div>
</div>
