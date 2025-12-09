#!/usr/bin/env kotlin
@file:DependsOn("org.json:json:20210307")

/**
 * generate_kotlin.main.kts
 * Kotlin code generator for MTV protocol v2.0
 *
 * Reads protocol/protocol.json (v2.0 schema):
 * {
 *   "version": "2.0.0",
 *   "meta": {...},
 *   "namespaces": {
 *       "<namespace>": {
 *            "description": "...",
 *            "events": {
 *                "<event>": {
 *                     "description": "...",
 *                     "direction": "client→server",
 *                     "phase": "...",
 *                     "payload": { field: type }
 *                }
 *            }
 *       }
 *   }
 * }
 *
 * Generates:
 *   out/kotlin/enums/*.kt
 *   out/kotlin/models/*.kt
 */

import java.io.File
import org.json.JSONObject
import org.json.JSONArray

// ------------------------------------------------------------
// Utilities
// ------------------------------------------------------------

fun readJson(path: String): JSONObject =
    JSONObject(File(path).readText(Charsets.UTF_8))

fun ensureDir(f: File) {
    if (!f.exists()) f.mkdirs()
}

fun kotlinType(t: String): String = when {
    t == "string" -> "String"
    t == "number" -> "Double"
    t == "boolean" -> "Boolean"
    t == "object" -> "Map<String, Any>"
    t.startsWith("array<") && t.endsWith(">") -> {
        val inner = t.removePrefix("array<").removeSuffix(">")
        "List<${kotlinType(inner)}>"
    }
    else -> "Any"
}

// ------------------------------------------------------------
// Enum generator
// ------------------------------------------------------------

fun genEnum(namespace: String, events: JSONObject): String {
    val className = namespace.replaceFirstChar { it.uppercase() } + "Event"

    val items = events.keys().asSequence().toList()
    val enumLines = items.joinToString(",\n    ") { it.uppercase() }

    return """
        |// AUTO-GENERATED – DO NOT EDIT
        |package mtv_protocol.enums
        |
        |enum class $className {
        |    $enumLines
        |}
    """.trimMargin()
}

// ------------------------------------------------------------
// Models generator
// ------------------------------------------------------------

fun genModels(namespace: String, events: JSONObject): String {
    val classHeader = "// AUTO-GENERATED – DO NOT EDIT\npackage mtv_protocol.models\n"

    val blocks = mutableListOf<String>()
    val nsHeader = "import mtv_protocol.enums.*\n"

    events.keys().forEach { eventName ->
        val ev = events.getJSONObject(eventName)
        val payload = ev.getJSONObject("payload")

        val className = "${eventName}Payload"
        val fields = payload.keys().asSequence().toList()

        val fieldLines = if (fields.isEmpty()) {
            "    // no payload fields\n"
        } else {
            fields.joinToString("\n") { key ->
                val type = kotlinType(payload.getString(key))
                "    val $key: $type"
            }
        }

        blocks += """
            |data class $className(
            |$fieldLines
            |)
        """.trimMargin()
    }

    return classHeader + "\n" + nsHeader + "\n" + blocks.joinToString("\n\n")
}

// ------------------------------------------------------------
// Main
// ------------------------------------------------------------

val repoRoot = File("").absoluteFile.parentFile.parentFile
println("📁 Repo root = $repoRoot")

val protocolFile = File(repoRoot, "protocol/protocol.json")
if (!protocolFile.exists()) {
    throw IllegalStateException("❌ protocol.json not found at: $protocolFile")
}

val protocol = readJson(protocolFile.path)
val namespaces = protocol.getJSONObject("namespaces")

val outRoot = File(repoRoot, "protocol/out/kotlin")
val enumDir = File(outRoot, "enums")
val modelDir = File(outRoot, "models")

ensureDir(enumDir)
ensureDir(modelDir)

println("🛠 Output dir = $outRoot")
println("🚀 Generating enums + models per namespace...")

namespaces.keys().forEach { ns ->
    val nsObj = namespaces.getJSONObject(ns)
    val events = nsObj.getJSONObject("events")

    // enum
    val enumFile = File(enumDir, "${ns.replaceFirstChar { it.uppercase() }}Events.kt")
    enumFile.writeText(genEnum(ns, events))

    // models
    val modelFile = File(modelDir, "${ns.replaceFirstChar { it.uppercase() }}Models.kt")
    modelFile.writeText(genModels(ns, events))

    println("   ✔ $ns (${events.length()} events)")
}

println("\n🎉 Kotlin codegen complete.")

