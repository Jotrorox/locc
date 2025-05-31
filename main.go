package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"

	"github.com/charmbracelet/lipgloss"
)

var (
	// Simple color palette
	headerColor = lipgloss.Color("#00D7FF") // Cyan
	fileColor   = lipgloss.Color("#FFFFFF") // White
	lineColor   = lipgloss.Color("#00FF87") // Green
	totalColor  = lipgloss.Color("#FFD700") // Gold
	errorColor  = lipgloss.Color("#FF5F87") // Red

	// Simple styles
	headerStyle = lipgloss.NewStyle().Foreground(headerColor).Bold(true)
	fileStyle   = lipgloss.NewStyle().Foreground(fileColor)
	lineStyle   = lipgloss.NewStyle().Foreground(lineColor).Bold(true)
	totalStyle  = lipgloss.NewStyle().Foreground(totalColor).Bold(true)
	errorStyle  = lipgloss.NewStyle().Foreground(errorColor).Bold(true)
)

// File type information
type FileTypeInfo struct {
	Name       string
	Extensions []string
	Files      int
	Lines      int
	FileList   []FileInfo
}

type FileInfo struct {
	Path  string
	Lines int
}

var fileTypeMap = map[string]string{
	".go":    "Go",
	".js":    "JavaScript",
	".ts":    "TypeScript",
	".py":    "Python",
	".java":  "Java",
	".c":     "C",
	".cpp":   "C++",
	".h":     "C Header",
	".hpp":   "C++ Header",
	".cs":    "C#",
	".php":   "PHP",
	".rb":    "Ruby",
	".rs":    "Rust",
	".html":  "HTML",
	".css":   "CSS",
	".scss":  "SCSS",
	".sass":  "Sass",
	".jsx":   "JSX",
	".tsx":   "TSX",
	".vue":   "Vue",
	".xml":   "XML",
	".json":  "JSON",
	".yaml":  "YAML",
	".yml":   "YAML",
	".toml":  "TOML",
	".sql":   "SQL",
	".sh":    "Shell",
	".bash":  "Bash",
	".zsh":   "Zsh",
	".fish":  "Fish",
	".ps1":   "PowerShell",
	".bat":   "Batch",
	".cmd":   "Command",
	".lua":   "Lua",
	".r":     "R",
	".m":     "Objective-C",
	".mm":    "Objective-C++",
	".swift": "Swift",
	".kt":    "Kotlin",
	".scala": "Scala",
	".pl":    "Perl",
	".pm":    "Perl Module",
	".dart":  "Dart",
}

func main() {
	var fileMode bool
	flag.BoolVar(&fileMode, "f", false, "Show individual files instead of grouping by type")
	flag.BoolVar(&fileMode, "file-mode", false, "Show individual files instead of grouping by type")
	flag.Parse()

	args := flag.Args()
	if len(args) < 1 {
		fmt.Println(errorStyle.Render("Usage: locc [--file-mode|-f] <directory_or_file>"))
		os.Exit(1)
	}

	path := args[0]

	if fileMode {
		showFileMode(path)
	} else {
		showTypeMode(path)
	}
}

func showFileMode(path string) {
	totalLines := 0
	fileCount := 0

	fmt.Printf("%s %s\n", headerStyle.Render("Scanning:"), path)
	fmt.Printf("%s\n", headerStyle.Render("──────────────────────────────────────"))

	err := filepath.Walk(path, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if info.IsDir() {
			return nil
		}

		ext := strings.ToLower(filepath.Ext(filePath))
		if _, exists := fileTypeMap[ext]; !exists {
			return nil
		}

		lines, err := countLinesInFile(filePath)
		if err != nil {
			fmt.Printf("%s %s: %v\n", errorStyle.Render("Error"), filePath, err)
			return nil
		}

		relPath := strings.TrimPrefix(filePath, path)
		relPath = strings.TrimPrefix(relPath, "/")
		if relPath == "" {
			relPath = filepath.Base(filePath)
		}

		fmt.Printf("%-50s %s\n",
			fileStyle.Render(relPath),
			lineStyle.Render(fmt.Sprintf("%6d", lines)))

		totalLines += lines
		fileCount++

		return nil
	})

	if err != nil {
		fmt.Printf("%s %v\n", errorStyle.Render("Error walking directory:"), err)
		os.Exit(1)
	}

	fmt.Printf("%s\n", headerStyle.Render("──────────────────────────────────────"))
	fmt.Printf("%-50s %s\n",
		totalStyle.Render("Total"),
		totalStyle.Render(fmt.Sprintf("%6d", totalLines)))
	fmt.Printf("Files: %s\n", totalStyle.Render(strconv.Itoa(fileCount)))
}

func showTypeMode(path string) {
	fileTypes := make(map[string]*FileTypeInfo)
	totalLines := 0
	totalFiles := 0

	fmt.Printf("%s %s\n", headerStyle.Render("Scanning:"), path)
	fmt.Printf("%s\n", headerStyle.Render("──────────────────────────────────────"))

	err := filepath.Walk(path, func(filePath string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if info.IsDir() {
			return nil
		}

		ext := strings.ToLower(filepath.Ext(filePath))
		typeName, exists := fileTypeMap[ext]
		if !exists {
			return nil
		}

		lines, err := countLinesInFile(filePath)
		if err != nil {
			fmt.Printf("%s %s: %v\n", errorStyle.Render("Error"), filePath, err)
			return nil
		}

		if fileTypes[typeName] == nil {
			fileTypes[typeName] = &FileTypeInfo{
				Name:     typeName,
				FileList: make([]FileInfo, 0),
			}
		}

		relPath := strings.TrimPrefix(filePath, path)
		relPath = strings.TrimPrefix(relPath, "/")
		if relPath == "" {
			relPath = filepath.Base(filePath)
		}

		fileTypes[typeName].Files++
		fileTypes[typeName].Lines += lines
		fileTypes[typeName].FileList = append(fileTypes[typeName].FileList, FileInfo{
			Path:  relPath,
			Lines: lines,
		})

		totalLines += lines
		totalFiles++

		return nil
	})

	if err != nil {
		fmt.Printf("%s %v\n", errorStyle.Render("Error walking directory:"), err)
		os.Exit(1)
	}

	// Sort file types by total lines (descending)
	var sortedTypes []*FileTypeInfo
	for _, typeInfo := range fileTypes {
		sortedTypes = append(sortedTypes, typeInfo)
	}
	sort.Slice(sortedTypes, func(i, j int) bool {
		return sortedTypes[i].Lines > sortedTypes[j].Lines
	})

	// Display results grouped by file type
	for _, typeInfo := range sortedTypes {
		fmt.Printf("%-30s %s files %s lines\n",
			headerStyle.Render(typeInfo.Name),
			fileStyle.Render(fmt.Sprintf("%3d", typeInfo.Files)),
			lineStyle.Render(fmt.Sprintf("%6d", typeInfo.Lines)))
	}

	fmt.Printf("%s\n", headerStyle.Render("──────────────────────────────────────"))
	fmt.Printf("%-30s %s files %s lines\n",
		totalStyle.Render("Total"),
		totalStyle.Render(fmt.Sprintf("%3d", totalFiles)),
		totalStyle.Render(fmt.Sprintf("%6d", totalLines)))
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
