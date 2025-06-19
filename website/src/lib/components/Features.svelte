<section class="py-20 bg-white dark:bg-gray-800">
	<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
		<div class="text-center mb-16">
			<h2 class="text-4xl font-bold text-gray-900 dark:text-white mb-4">
				Why Choose LOCC?
			</h2>
			<p class="text-xl text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
				Built with performance and usability in mind, LOCC delivers accurate results with beautiful output.
			</p>
		</div>
		
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
			<!-- Fast Performance -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 border border-blue-100 dark:border-blue-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-blue-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">⚡</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Blazingly Fast
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					Written in Zig for maximum performance. Analyze large codebases in seconds, not minutes.
				</p>
			</div>
			
			<!-- Beautiful Output -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 border border-purple-100 dark:border-purple-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-purple-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">🎨</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Beautiful Output
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					Colorful and easy-to-read terminal output that makes code analysis a pleasure.
				</p>
			</div>
			
			<!-- Multi-language Support -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 border border-green-100 dark:border-green-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-green-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">🌐</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Multi-language
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					Support for dozens of programming languages including C, Python, JavaScript, Rust, and more.
				</p>
			</div>
			
			<!-- Pattern Filtering -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-yellow-50 to-orange-50 dark:from-yellow-900/20 dark:to-orange-900/20 border border-yellow-100 dark:border-yellow-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-yellow-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">🔍</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Smart Filtering
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					Advanced pattern matching with wildcards to analyze exactly what you need.
				</p>
			</div>
			
			<!-- File Mode -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-red-50 to-rose-50 dark:from-red-900/20 dark:to-rose-900/20 border border-red-100 dark:border-red-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-red-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">📊</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Detailed Analysis
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					File mode shows detailed breakdowns and statistics for comprehensive project analysis.
				</p>
			</div>
			
			<!-- Configurable -->
			<div class="group p-8 rounded-2xl bg-gradient-to-br from-indigo-50 to-blue-50 dark:from-indigo-900/20 dark:to-blue-900/20 border border-indigo-100 dark:border-indigo-800 hover:shadow-xl transition-all duration-300">
				<div class="w-12 h-12 bg-indigo-500 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
					<span class="text-2xl">⚙️</span>
				</div>
				<h3 class="text-xl font-semibold text-gray-900 dark:text-white mb-3">
					Highly Configurable
				</h3>
				<p class="text-gray-600 dark:text-gray-300">
					JSON configuration file support to customize behavior and ignore specific files or directories.
				</p>
			</div>
		</div>
		
		<!-- Supported Languages Section -->
		<div class="mt-20 p-8 rounded-2xl bg-gradient-to-r from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-700">
			<h3 class="text-2xl font-bold text-center text-gray-900 dark:text-white mb-8">
				Supported Languages
			</h3>
			<div class="flex flex-wrap justify-center gap-3">
				{#each ['JavaScript', 'TypeScript', 'Python', 'Java', 'C++', 'C', 'Rust', 'Go', 'PHP', 'Ruby', 'Swift', 'Kotlin', 'C#', 'HTML', 'CSS', 'SCSS', 'Vue', 'React', 'Svelte', 'Zig', 'Shell', 'Lua', 'Perl', 'R', 'SQL', 'JSON', 'YAML', 'XML'] as language}
					<span class="px-3 py-1 bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 rounded-full text-sm font-medium">
						{language}
					</span>
				{/each}
			</div>
		</div>
	</div>
</section>
