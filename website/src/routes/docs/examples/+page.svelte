<svelte:head>
	<title>Examples - LOCC Documentation</title>
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		Examples
	</h1>
	
	<p class="text-xl text-gray-600 dark:text-gray-300 mb-8">
		Practical examples of using LOCC in various scenarios and project types.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Basic Usage
	</h2>
	
	<div class="space-y-6">
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				Count Lines in Current Directory
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
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
			<p class="text-gray-600 dark:text-gray-300">
				Analyzes the current directory and shows line counts grouped by programming language.
			</p>
		</div>

		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				Count Lines in Specific Directory
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc /path/to/your/project</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
					<div class="text-blue-400">📁 Analyzing /path/to/your/project...</div>
					<div class="mt-2">
						<div class="text-orange-400">🦀 Rust          2,456 lines</div>
						<div class="text-blue-400">🔵 Zig              891 lines</div>
						<div class="text-green-400">📝 Markdown         123 lines</div>
					</div>
					<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
						✨ Total: 3,470 lines of code
					</div>
				</div>
			</div>
			<p class="text-gray-600 dark:text-gray-300">
				Specify a custom directory to analyze instead of the current working directory.
			</p>
		</div>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		File Mode
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			Show File Counts Instead of Line Counts
		</h3>
		<div class="bg-gray-900 rounded p-4 mb-4">
			<div class="text-green-400 font-mono text-sm">$ locc --file-mode</div>
			<div class="text-gray-300 font-mono text-sm">
				<div class="text-green-400 font-mono text-sm">$ locc -f</div>
			</div>
			<div class="text-gray-300 font-mono text-sm mt-2">
				<div class="text-blue-400">📁 Analyzing project...</div>
				<div class="mt-2">
					<div class="text-purple-400">🔥 TypeScript      12 files</div>
					<div class="text-yellow-400">⚡ JavaScript       8 files</div>
					<div class="text-red-400">🎨 CSS              5 files</div>
					<div class="text-green-400">📝 HTML             3 files</div>
				</div>
				<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
					✨ Total: 28 files
				</div>
			</div>
		</div>
		<p class="text-gray-600 dark:text-gray-300">
			Use <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--file-mode</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-f</code> to show file counts instead of line counts.
		</p>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Regex Filtering
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			Filter Files Using Regular Expressions
		</h3>
		<div class="space-y-4">
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Only count TypeScript files</div>
				<div class="text-white font-mono text-sm">$ locc --regex "\.tsx?$"</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Only count files in src directory</div>
				<div class="text-white font-mono text-sm">$ locc --regex "^src/"</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Exclude test files</div>
				<div class="text-white font-mono text-sm">$ locc --regex "^(?!.*test)"</div>
			</div>
		</div>
		<p class="text-gray-600 dark:text-gray-300 mt-4">
			Use <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--regex</code> or <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-r</code> to filter files and directories using regular expressions.
		</p>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Help and Information
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			Show Help Information
		</h3>
		<div class="bg-gray-900 rounded p-4 mb-4">
			<div class="text-green-400 font-mono text-sm">$ locc --help</div>
			<div class="text-green-400 font-mono text-sm">$ locc -h</div>
		</div>
		<p class="text-gray-600 dark:text-gray-300">
			Display usage information and available command-line options.
		</p>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Real-World Project Examples
	</h2>
	
	<div class="space-y-6">
		<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-blue-900 dark:text-blue-100 mb-4">
				💻 Web Development Project
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc ./my-react-app</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
					<div class="text-blue-400">📁 Analyzing ./my-react-app...</div>
					<div class="mt-2">
						<div class="text-purple-400">⚛️  TypeScript    8,234 lines</div>
						<div class="text-yellow-400">⚡ JavaScript    2,156 lines</div>
						<div class="text-red-400">🎨 CSS          1,432 lines</div>
						<div class="text-green-400">📝 HTML           298 lines</div>
						<div class="text-pink-400">💅 SCSS          1,089 lines</div>
						<div class="text-blue-300">📄 JSON           234 lines</div>
					</div>
					<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
						✨ Total: 13,443 lines of code
					</div>
				</div>
			</div>
			<p class="text-blue-800 dark:text-blue-200 text-sm">
				Typical output for a React/Next.js project with TypeScript, styling, and configuration files.
			</p>
		</div>

		<div class="bg-orange-50 dark:bg-orange-900/20 border border-orange-200 dark:border-orange-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-orange-900 dark:text-orange-100 mb-4">
				🦀 Systems Programming Project
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc ./rust-cli-tool</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
					<div class="text-blue-400">📁 Analyzing ./rust-cli-tool...</div>
					<div class="mt-2">
						<div class="text-orange-400">🦀 Rust          5,671 lines</div>
						<div class="text-gray-400">⚙️  TOML            89 lines</div>
						<div class="text-green-400">📝 Markdown        156 lines</div>
						<div class="text-blue-300">📄 YAML            45 lines</div>
					</div>
					<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
						✨ Total: 5,961 lines of code
					</div>
				</div>
			</div>
			<p class="text-orange-800 dark:text-orange-200 text-sm">
				Clean output for a Rust project showing the main language and configuration files.
			</p>
		</div>

		<div class="bg-indigo-50 dark:bg-indigo-900/20 border border-indigo-200 dark:border-indigo-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-indigo-900 dark:text-indigo-100 mb-4">
				⚡ Zig Project (This Project!)
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc ./locc</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
					<div class="text-blue-400">📁 Analyzing ./locc...</div>
					<div class="mt-2">
						<div class="text-blue-400">🔵 Zig           1,847 lines</div>
						<div class="text-green-400">📝 Markdown        298 lines</div>
						<div class="text-blue-300">📄 JSON          114 lines</div>
					</div>
					<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
						✨ Total: 2,259 lines of code
					</div>
				</div>
			</div>
			<p class="text-indigo-800 dark:text-indigo-200 text-sm">
				LOCC analyzing itself! Shows the clean, minimal structure of a Zig project.
			</p>
		</div>

		<div class="bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-green-900 dark:text-green-100 mb-4">
				🐍 Python Data Science Project
			</h3>
			<div class="bg-gray-900 rounded p-4 mb-4">
				<div class="text-green-400 font-mono text-sm">$ locc ./ml-pipeline</div>
				<div class="text-gray-300 font-mono text-sm mt-2">
					<div class="text-blue-400">📁 Analyzing ./ml-pipeline...</div>
					<div class="mt-2">
						<div class="text-green-400">🐍 Python        3,234 lines</div>
						<div class="text-purple-400">📊 Jupyter        1,567 lines</div>
						<div class="text-blue-300">📄 YAML            89 lines</div>
						<div class="text-gray-400">⚙️  TOML            34 lines</div>
						<div class="text-green-400">📝 Markdown        245 lines</div>
					</div>
					<div class="mt-2 border-t border-gray-600 pt-2 text-cyan-400">
						✨ Total: 5,169 lines of code
					</div>
				</div>
			</div>
			<p class="text-green-800 dark:text-green-200 text-sm">
				Python project with Jupyter notebooks, configuration files, and documentation.
			</p>
		</div>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Combining Options
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			Advanced Usage Examples
		</h3>
		<div class="space-y-4">
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Count TypeScript files only, show file counts</div>
				<div class="text-white font-mono text-sm">$ locc --file-mode --regex "\.tsx?$" ./src</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Analyze multiple projects</div>
				<div class="text-white font-mono text-sm">$ locc ./frontend ./backend ./shared</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Count only source files (exclude configs and docs)</div>
				<div class="text-white font-mono text-sm">$ locc --regex "\.(ts|js|py|rs|go|java|cpp|c)$"</div>
			</div>
		</div>
	</div>

	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-6">
		Tips and Best Practices
	</h2>
	
	<div class="bg-gradient-to-r from-purple-50 to-blue-50 dark:from-purple-900/20 dark:to-blue-900/20 border border-purple-200 dark:border-purple-800 rounded-lg p-6">
		<h3 class="text-lg font-semibold text-purple-900 dark:text-purple-100 mb-4">
			💡 Pro Tips
		</h3>
		<ul class="text-purple-800 dark:text-purple-200 space-y-3">
			<li class="flex items-start">
				<span class="text-purple-500 mr-2">•</span>
				<div>
					<strong>Project Analysis:</strong> Run LOCC from your project root to get the most accurate results with automatic ignored paths detection.
				</div>
			</li>
			<li class="flex items-start">
				<span class="text-purple-500 mr-2">•</span>
				<div>
					<strong>Performance:</strong> LOCC is optimized for speed and can analyze large codebases (100k+ lines) in seconds.
				</div>
			</li>
			<li class="flex items-start">
				<span class="text-purple-500 mr-2">•</span>
				<div>
					<strong>Regex Patterns:</strong> Use regex filtering to focus on specific parts of your codebase or exclude certain file types.
				</div>
			</li>
			<li class="flex items-start">
				<span class="text-purple-500 mr-2">•</span>
				<div>
					<strong>File Mode:</strong> Use file mode when you want to understand the structure of your project rather than just the size.
				</div>
			</li>
			<li class="flex items-start">
				<span class="text-purple-500 mr-2">•</span>
				<div>
					<strong>Automation:</strong> LOCC works great in CI/CD pipelines for tracking codebase growth over time.
				</div>
			</li>
		</ul>
	</div>
</div>
