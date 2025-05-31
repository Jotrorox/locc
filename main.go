package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: locc <directory_or_file>")
		os.Exit(1)
	}

	path := os.Args[1]
	totalLines := 0

	err := filepath.Walk(path, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if info.IsDir() {
			return nil
		}

		ext := strings.ToLower(filepath.Ext(filePath))
		codeExtensions := map[string]bool{
			".go":   true,
			".js":   true,
			".ts":   true,
			".py":   true,
			".java": true,
			".c":    true,
			".cpp":  true,
			".h":    true,
			".hpp":  true,
			".cs":   true,
			".php":  true,
			".rb":   true,
			".rs":   true,
		}

		if !codeExtensions[ext] {
			return nil
		}

		lines, err := countLinesInFile(filePath)
		if err != nil {
			fmt.Printf("Error reading %s: %v\n", filePath, err)
			return nil
		}

		fmt.Printf("%s: %d lines\n", filePath, lines)
		totalLines += lines

		return nil
	})

	if err != nil {
		fmt.Printf("Error walking directory: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("\nTotal lines of code: %d\n", totalLines)
}

func countLinesInFile(filePath string) (int, error) {
	file, err := os.Open(filePath)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	lineCount := 0

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line != "" {
			lineCount++
		}
	}

	if err := scanner.Err(); err != nil {
		return 0, err
	}

	return lineCount, nil
}
