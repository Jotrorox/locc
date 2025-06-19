<script lang="ts">
	import Hero from '$lib/components/Hero.svelte';
	import Features from '$lib/components/Features.svelte';
	import Installation from '$lib/components/Installation.svelte';
	import Footer from '$lib/components/Footer.svelte';
</script>

<svelte:head>
	<title>LOCC - Lines of Code Counter</title>
	<meta name="description" content="A fast and beautiful command-line tool for counting lines of code across multiple programming languages with colorful terminal output." />
</svelte:head>

<main>
	<Hero />
	<Features />
	<Installation />
	<Footer />
</main>
