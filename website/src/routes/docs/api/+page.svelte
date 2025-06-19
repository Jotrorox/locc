<svelte:head>
	<title>API Reference - LOCC Documentation</title>
</svelte:head>

<div class="prose prose-lg max-w-4xl dark:prose-invert">
	<h1 class="text-4xl font-bold text-gray-900 dark:text-white mb-8">
		API Reference
	</h1>
	
	<p class="text-xl text-gray-600 dark:text-gray-300 mb-8">
		Complete reference for all LOCC command-line options and their usage.
	</p>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Command Syntax
	</h2>
	
	<div class="bg-gray-900 rounded-lg p-6 mb-8">
		<div class="text-green-400 font-mono text-lg">locc [OPTIONS] [DIRECTORY]</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Arguments
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
			<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">DIRECTORY</code>
		</h3>
		<p class="text-gray-600 dark:text-gray-300 mb-4">
			Optional. The directory to analyze. If not specified, analyzes the current directory.
		</p>
		<div class="bg-gray-50 dark:bg-gray-700 rounded p-4">
			<div class="text-sm text-gray-600 dark:text-gray-300">
				<strong>Type:</strong> String (path)<br/>
				<strong>Default:</strong> Current directory (.)<br/>
				<strong>Examples:</strong> <code>./src</code>, <code>/home/user/project</code>, <code>../myapp</code>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Options
	</h2>
	
	<div class="space-y-6">
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--file-mode</code>, <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-f</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Show file count grouped by type instead of line count.
			</p>
			<div class="bg-gray-50 dark:bg-gray-700 rounded p-4 mb-4">
				<div class="text-sm text-gray-600 dark:text-gray-300">
					<strong>Type:</strong> Boolean flag<br/>
					<strong>Default:</strong> false (line count mode)<br/>
					<strong>Conflicts:</strong> None
				</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Examples</div>
				<div class="text-white font-mono text-sm">locc --file-mode</div>
				<div class="text-white font-mono text-sm">locc -f ./src</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--regex</code>, <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-r</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Filter files using wildcard patterns. Supports <code>*</code> (any characters) and <code>?</code> (single character).
			</p>
			<div class="bg-gray-50 dark:bg-gray-700 rounded p-4 mb-4">
				<div class="text-sm text-gray-600 dark:text-gray-300">
					<strong>Type:</strong> String (pattern)<br/>
					<strong>Default:</strong> No filtering (all files)<br/>
					<strong>Wildcards:</strong> <code>*</code> = any chars, <code>?</code> = single char
				</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Examples</div>
				<div class="text-white font-mono text-sm">locc -r "*.js"</div>
				<div class="text-white font-mono text-sm">locc --regex "test*"</div>
				<div class="text-white font-mono text-sm">locc -r "*component*"</div>
				<div class="text-white font-mono text-sm">locc -r "build.zi?"</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--help</code>, <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-h</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Display help information and usage examples.
			</p>
			<div class="bg-gray-50 dark:bg-gray-700 rounded p-4 mb-4">
				<div class="text-sm text-gray-600 dark:text-gray-300">
					<strong>Type:</strong> Boolean flag<br/>
					<strong>Behavior:</strong> Shows help and exits<br/>
					<strong>Precedence:</strong> Overrides other options
				</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Examples</div>
				<div class="text-white font-mono text-sm">locc --help</div>
				<div class="text-white font-mono text-sm">locc -h</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">--version</code>, <code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">-v</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Display the current version of LOCC.
			</p>
			<div class="bg-gray-50 dark:bg-gray-700 rounded p-4 mb-4">
				<div class="text-sm text-gray-600 dark:text-gray-300">
					<strong>Type:</strong> Boolean flag<br/>
					<strong>Behavior:</strong> Shows version and exits<br/>
					<strong>Output format:</strong> <code>locc v1.0.0</code>
				</div>
			</div>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Examples</div>
				<div class="text-white font-mono text-sm">locc --version</div>
				<div class="text-white font-mono text-sm">locc -v</div>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Option Combinations
	</h2>
	
	<div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-6 mb-8">
		<h3 class="text-lg font-semibold text-blue-900 dark:text-blue-100 mb-4">
			Valid Combinations
		</h3>
		<div class="bg-gray-900 rounded p-4 space-y-2">
			<div class="text-green-400 font-mono text-sm"># File mode with pattern filtering</div>
			<div class="text-white font-mono text-sm">locc --file-mode --regex "*.py"</div>
			<div class="text-white font-mono text-sm">locc -f -r "*.js" ./src</div>
			
			<div class="text-green-400 font-mono text-sm mt-4"># Pattern filtering with directory</div>
			<div class="text-white font-mono text-sm">locc -r "test*" ./tests</div>
			<div class="text-white font-mono text-sm">locc --regex "*.md" ./docs</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Exit Codes
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden mb-8">
		<table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
			<thead class="bg-gray-50 dark:bg-gray-700">
				<tr>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Code</th>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Meaning</th>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Description</th>
				</tr>
			</thead>
			<tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">0</td>
					<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">Success</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Analysis completed successfully</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">1</td>
					<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">General Error</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Invalid arguments or general failure</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">2</td>
					<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">Directory Not Found</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Specified directory does not exist</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">3</td>
					<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">Permission Denied</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Insufficient permissions to read directory</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Environment Variables
	</h2>
	
	<div class="space-y-4 mb-8">
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">LOCC_CONFIG</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Override the default configuration file path.
			</p>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Set custom config path</div>
				<div class="text-white font-mono text-sm">export LOCC_CONFIG=/path/to/custom/config.json</div>
				<div class="text-white font-mono text-sm">locc ./src</div>
			</div>
		</div>
		
		<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg p-6">
			<h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-2">
				<code class="bg-gray-100 dark:bg-gray-700 px-2 py-1 rounded">NO_COLOR</code>
			</h3>
			<p class="text-gray-600 dark:text-gray-300 mb-4">
				Disable colored output when set to any value.
			</p>
			<div class="bg-gray-900 rounded p-4">
				<div class="text-green-400 font-mono text-sm mb-2"># Disable colors</div>
				<div class="text-white font-mono text-sm">export NO_COLOR=1</div>
				<div class="text-white font-mono text-sm">locc ./src</div>
			</div>
		</div>
	</div>
	
	<h2 class="text-2xl font-semibold text-gray-900 dark:text-white mb-4">
		Pattern Matching Reference
	</h2>
	
	<div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden mb-8">
		<table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
			<thead class="bg-gray-50 dark:bg-gray-700">
				<tr>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Pattern</th>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Matches</th>
					<th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">Example Files</th>
				</tr>
			</thead>
			<tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">*.js</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">All JavaScript files</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">main.js, app.js, utils.js</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">test*</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Files starting with "test"</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">test.js, test_utils.py, testfile.txt</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">*component*</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Files containing "component"</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">MyComponent.vue, component.js, UIComponent.tsx</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">build.zi?</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">build.zi + any single character</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">build.zig, build.zip, build.zil</td>
				</tr>
				<tr>
					<td class="px-6 py-4 whitespace-nowrap text-sm font-mono text-gray-900 dark:text-white">README*</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">Files starting with "README"</td>
					<td class="px-6 py-4 text-sm text-gray-600 dark:text-gray-300">README.md, README.txt, README</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 rounded-lg p-6">
		<h3 class="text-lg font-semibold text-green-900 dark:text-green-100 mb-2">
			💡 API Usage Tips
		</h3>
		<ul class="text-green-800 dark:text-green-200 space-y-2 text-sm">
			<li>• Quote patterns to prevent shell expansion: <code>locc -r "*.js"</code></li>
			<li>• Use absolute paths for consistent results across environments</li>
			<li>• Check exit codes in scripts for error handling</li>
			<li>• Combine options for more specific analysis</li>
			<li>• Use environment variables for automation</li>
		</ul>
	</div>
</div>
