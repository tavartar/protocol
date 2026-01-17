#!/usr/bin/env kotlin
@file:DependsOn("com.fasterxml.jackson.module:jackson-module-kotlin:2.15.+")

import java.io.File
import kotlin.io.path.Path
import kotlin.io.path.createDirectories
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue

// ---------------------------------------------------------------------------
// Args
// ---------------------------------------------------------------------------

if (args.size != 2) {
    System.err.println("Usage: generate_kotlin.main.kts <protocol.json> <out_dir>")
    kotlin.system.exitProcess(1)
}

val protocolPath = args[0]
val outDir = args[1]

// ---------------------------------------------------------------------------
// Load protocol
// ---------------------------------------------------------------------------

val mapper = jacksonObjectMapper()
val protocolFile = File(protocolPath)

if (!protocolFile.exists()) {
    System.err.println("❌ Protocol file not found: $protocolPath")
    kotlin.system.exitProcess(1)
}

println("[codegen-kotlin] reading protocol: ${protocolFile.absolutePath}")

val protocol: Map<String, Any> = mapper.readValue(protocolFile)

// ---------------------------------------------------------------------------
// Prepare output directory
// ---------------------------------------------------------------------------

val outPath = Path(outDir)
outPath.createDirectories()

// ---------------------------------------------------------------------------
// Generate Kotlin code (simple v1)
// ---------------------------------------------------------------------------

val builder = StringBuilder()
builder.appendLine("// ------------------------------------------------------------------")
builder.appendLine("// Auto-generated Kotlin protocol (v${protocol["version"] ?: "unknown"})")
builder.appendLine("// ------------------------------------------------------------------")
builder.appendLine()
builder.appendLine("package mtv.protocol")
builder.appendLine()

val namespaces = protocol["namespaces"] as? Map<*, *> ?: emptyMap<Any, Any>()

for ((nsName, nsVal) in namespaces) {
    val ns = nsName.toString()
    val events = (nsVal as Map<*, *>)["events"] as? Map<*, *> ?: continue

    builder.appendLine("// Namespace: $ns")
    for ((evName, _) in events) {
        builder.appendLine("const val ${ns.uppercase()}_${evName.toString().uppercase()} = \"$evName\"")
    }
    builder.appendLine()
}

// ---------------------------------------------------------------------------
// Write file
// ---------------------------------------------------------------------------

val outFile = outPath.resolve("mtv_protocol.kt").toFile()
outFile.writeText(builder.toString())

println("[done] Kotlin code generated at: ${outFile.absolutePath}")

