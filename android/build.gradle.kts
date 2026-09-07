allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Only redirect build dir for subprojects on the same drive root as the
    // project. Pub-cache plugins on C: cannot share a build dir on D: because
    // Gradle / Kotlin cannot relativize paths across Windows drive roots.
    val buildRoot = newBuildDir.asFile.toPath().root
    val projectRoot = project.projectDir.toPath().root
    if (buildRoot == projectRoot) {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.value(newSubprojectBuildDir)
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
