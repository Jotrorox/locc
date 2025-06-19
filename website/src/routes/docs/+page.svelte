<svelte:head>
	<title>Documentation - LOCC</title>
	<meta name="description" content="Complete documentation for LOCC - Lines of Code Counter" />
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		LOCC Documentation
	</h1>
	
	<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-6 mb-8">
		<h2 class="text-xl font-semibold text-blue-900 dark:text-blue-100 mb-2">
			Welcome to LOCC
		</h2>
		<p class="text-blue-800 dark:text-blue-200">
			LOCC (Lines of Code Counter) is a fast and beautiful command-line tool for counting lines of code across multiple programming languages with colorful terminal output.
		</p>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		What is LOCC?
	</h2>
	
	<p class="text-gray-600 dark:text-gray-300 mb-6">
		LOCC is a high-performance command-line utility written in Zig that analyzes your codebase and provides detailed statistics about lines of code across different programming languages. Whether you're working on a small script or a large enterprise application, LOCC delivers fast and accurate results with beautiful, colorful output.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Key Features
	</h2>
	
	<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
		<div class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">⚡ Lightning Fast</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Written in Zig for maximum performance. Analyze large codebases in seconds.
			</p>
		</div>
		
		<div class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🎨 Beautiful Output</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Colorful and easy-to-read terminal output that makes code analysis enjoyable.
			</p>
		</div>
		
		<div class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🌐 Multi-Language</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Supports dozens of programming languages out of the box.
			</p>
		</div>
		
		<div class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🔍 Smart Filtering</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Advanced pattern matching with wildcards to analyze exactly what you need.
			</p>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Quick Start
	</h2>
	
	<div class="bg-gray-900 rounded-lg p-4 mb-6">
		<div class="text-green-400 font-mono text-sm mb-2"># Clone and build from source</div>
		<div class="text-white font-mono text-sm">git clone https://github.com/jotrorox/locc.git</div>
		<div class="text-white font-mono text-sm">cd locc</div>
		<div class="text-white font-mono text-sm">zig build --release=small</div>
		
		<div class="text-green-400 font-mono text-sm mt-4 mb-2"># Basic usage</div>
		<div class="text-white font-mono text-sm">./zig-out/bin/locc</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Navigation
	</h2>
	
	<div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
		<a href="/docs/installation" class="block p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg hover:shadow-md transition-shadow">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">📦 Installation</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Learn how to install LOCC on your system using various methods.
			</p>
		</a>
		
		<a href="/docs/usage" class="block p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg hover:shadow-md transition-shadow">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">🚀 Usage</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Discover all the command-line options and how to use them effectively.
			</p>
		</a>
		
		<a href="/docs/configuration" class="block p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg hover:shadow-md transition-shadow">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">⚙️ Configuration</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				Configure LOCC to suit your needs with JSON configuration files.
			</p>
		</a>
		
		<a href="/docs/examples" class="block p-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg hover:shadow-md transition-shadow">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">📚 Examples</h3>
			<p class="text-gray-600 dark:text-gray-300 text-sm">
				See real-world examples and use cases for LOCC.
			</p>
		</a>
	</div>
	
	<div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-6">
		<h3 class="text-lg font-semibold text-yellow-900 dark:text-yellow-100 mb-2">
			Need Help?
		</h3>
		<p class="text-yellow-800 dark:text-yellow-200 mb-4">
			If you encounter any issues or have questions, feel free to reach out!
		</p>
		<div class="flex space-x-4">
			<a href="https://github.com/jotrorox/locc/issues" target="_blank" rel="noopener noreferrer" class="text-yellow-600 dark:text-yellow-400 hover:text-yellow-800 dark:hover:text-yellow-200 font-medium">
				Report an Issue →
			</a>
			<a href="https://github.com/jotrorox/locc/discussions" target="_blank" rel="noopener noreferrer" class="text-yellow-600 dark:text-yellow-400 hover:text-yellow-800 dark:hover:text-yellow-200 font-medium">
				Ask a Question →
			</a>
		</div>
	</div>
</div>
