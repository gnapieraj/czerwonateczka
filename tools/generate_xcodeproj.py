#!/usr/bin/env python3
"""Emit a signed-empty Xcode 26-friendly project."""
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def uid(name: str) -> str:
    return uuid.uuid5(uuid.NAMESPACE_URL, f"czerwona:{name}").hex[:24].upper()


files = {
    "CzerwonaTeczkaApp.swift": "App/CzerwonaTeczkaApp.swift",
    "Models.swift": "Engine/Models.swift",
    "Copy.swift": "Engine/Copy.swift",
    "LessonLoader.swift": "Engine/LessonLoader.swift",
    "GameStore.swift": "Engine/GameStore.swift",
    "Canon.swift": "World/Canon.swift",
    "RootView.swift": "Views/RootView.swift",
    "SplashView.swift": "Views/SplashView.swift",
    "ComicStage.swift": "Views/ComicStage.swift",
    "ComicIntroView.swift": "Views/ComicIntroView.swift",
    "Components.swift": "Views/Components.swift",
    "DeskView.swift": "Views/DeskView.swift",
    "CasePlayView.swift": "Views/CasePlayView.swift",
    "AwarenessView.swift": "Views/AwarenessView.swift",
    "RatioView.swift": "Views/RatioView.swift",
    "SourcesView.swift": "Views/SourcesView.swift",
    "SettingsView.swift": "Views/SettingsView.swift",
    "HowToPlayView.swift": "Views/HowToPlayView.swift",
    "LessonPackTests.swift": "CzerwonaTeczkaTests/LessonPackTests.swift",
}

resources = {
    "Lessons.json": "Resources/Lessons.json",
    "PrivacyInfo.xcprivacy": "Resources/PrivacyInfo.xcprivacy",
    "Assets.xcassets": "Resources/Assets.xcassets",
    "GoboCaps-Regular.otf": "Resources/Fonts/GoboCaps-Regular.otf",
    "GoboCaps-Italic.otf": "Resources/Fonts/GoboCaps-Italic.otf",
    "OFL.txt": "Resources/Fonts/OFL.txt",
}

ids = {
    "project": uid("project"),
    "mainGroup": uid("mainGroup"),
    "appTarget": uid("appTarget"),
    "testTarget": uid("testTarget"),
    "appProduct": uid("appProduct"),
    "testProduct": uid("testProduct"),
    "products": uid("products"),
    "srcBuild": uid("srcBuild"),
    "resBuild": uid("resBuild"),
    "fwBuild": uid("fwBuild"),
    "testSrc": uid("testSrc"),
    "testRes": uid("testRes"),
    "testFw": uid("testFw"),
    "container": uid("container"),
    "appConfigList": uid("appConfigList"),
    "testConfigList": uid("testConfigList"),
    "projConfigList": uid("projConfigList"),
    "appDebug": uid("appDebug"),
    "appRelease": uid("appRelease"),
    "testDebug": uid("testDebug"),
    "testRelease": uid("testRelease"),
    "projDebug": uid("projDebug"),
    "projRelease": uid("projRelease"),
    "gApp": uid("gApp"),
    "gEngine": uid("gEngine"),
    "gViews": uid("gViews"),
    "gWorld": uid("gWorld"),
    "gRes": uid("gRes"),
    "gTests": uid("gTests"),
}

file_ids = {}
build_ids = {}
for name, path in {**files, **resources}.items():
    file_ids[name] = uid(f"ref:{path}")
    build_ids[name] = uid(f"build:{path}")
build_ids["Lessons.json.test"] = uid("build:Lessons.json.test")

common_proj = """
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				SDKROOT = iphoneos;
				SWIFT_APPROACHABLE_CONCURRENCY = YES;
				SWIFT_DEFAULT_ACTOR_ISOLATION = nonisolated;
				SWIFT_STRICT_CONCURRENCY = targeted;
				SWIFT_VERSION = 5.0;
"""

app_build = """
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = YES;
				INFOPLIST_FILE = Resources/AppInfo.plist;
				INFOPLIST_KEY_CFBundleDisplayName = "Czerwona Teczka";
				INFOPLIST_KEY_ITSAppUsesNonExemptEncryption = NO;
				INFOPLIST_KEY_LSApplicationCategoryType = "public.app-category.education";
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = UIInterfaceOrientationPortrait;
				LD_RUNPATH_SEARCH_PATHS = "$(inherited) @executable_path/Frameworks";
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = pl.czerwonateczka.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";
				SUPPORTS_MACCATALYST = NO;
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
"""

test_build = """
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = pl.czerwonateczka.app.tests;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/CzerwonaTeczka.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/CzerwonaTeczka";
"""

def fileref(name, path):
    if path.endswith(".xcassets"):
        ftype = "folder.assetcatalog"
    elif path.endswith(".json"):
        ftype = "text.json"
    elif path.endswith(".xcprivacy"):
        ftype = "text.xml"
    else:
        ftype = "sourcecode.swift"
    return f'\t\t{file_ids[name]} /* {name} */ = {{isa = PBXFileReference; lastKnownFileType = {ftype}; path = {name}; sourceTree = "<group>"; }};\n'


# file refs use path as filename because groups have the directory
# actually path should be just the filename when in a group with path

parts = []
parts.append("// !$*UTF8*$!\n{\n\tarchiveVersion = 1;\n\tclasses = {\n\t};\n\tobjectVersion = 56;\n\tobjects = {\n\n")

parts.append("/* Begin PBXBuildFile section */\n")
for name, path in files.items():
    if name == "LessonPackTests.swift":
        parts.append(f"\t\t{build_ids[name]} /* {name} in Sources */ = {{isa = PBXBuildFile; fileRef = {file_ids[name]} /* {name} */; }};\n")
    else:
        parts.append(f"\t\t{build_ids[name]} /* {name} in Sources */ = {{isa = PBXBuildFile; fileRef = {file_ids[name]} /* {name} */; }};\n")
for name in resources:
    parts.append(f"\t\t{build_ids[name]} /* {name} in Resources */ = {{isa = PBXBuildFile; fileRef = {file_ids[name]} /* {name} */; }};\n")
parts.append(f"\t\t{build_ids['Lessons.json.test']} /* Lessons.json in Resources */ = {{isa = PBXBuildFile; fileRef = {file_ids['Lessons.json']} /* Lessons.json */; }};\n")
parts.append("/* End PBXBuildFile section */\n\n")

parts.append("/* Begin PBXFileReference section */\n")
parts.append(f'\t\t{ids["appProduct"]} /* CzerwonaTeczka.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = CzerwonaTeczka.app; sourceTree = BUILT_PRODUCTS_DIR; }};\n')
parts.append(f'\t\t{ids["testProduct"]} /* CzerwonaTeczkaTests.xctest */ = {{isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = CzerwonaTeczkaTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; }};\n')
for name, path in {**files, **resources}.items():
    parts.append(fileref(name, path))
parts.append("/* End PBXFileReference section */\n\n")

def group(gid, name, children, path=None):
    ch = "".join(f"\t\t\t\t{c},\n" for c in children)
    p = f"\t\t\tpath = {path};\n" if path else ""
    return f"\t\t{gid} /* {name} */ = {{\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n{ch}\t\t\t);\n{p}\t\t\tname = {name};\n\t\t\tsourceTree = \"<group>\";\n\t\t}};\n"

# Groups with path so file refs can be filenames
parts.append("/* Begin PBXGroup section */\n")
parts.append(group(ids["gApp"], "App", [file_ids["CzerwonaTeczkaApp.swift"]], "App"))
parts.append(group(ids["gEngine"], "Engine", [file_ids[n] for n in ["Models.swift", "Copy.swift", "LessonLoader.swift", "GameStore.swift"]], "Engine"))
parts.append(group(ids["gViews"], "Views", [file_ids[n] for n in ["RootView.swift", "SplashView.swift", "ComicStage.swift", "ComicIntroView.swift", "Components.swift", "DeskView.swift", "HowToPlayView.swift", "CasePlayView.swift", "AwarenessView.swift", "RatioView.swift", "SourcesView.swift", "SettingsView.swift"]], "Views"))
parts.append(group(ids["gWorld"], "World", [file_ids["Canon.swift"]], "World"))
parts.append(group(ids["gRes"], "Resources", [file_ids[n] for n in ["Lessons.json", "PrivacyInfo.xcprivacy", "Assets.xcassets"]], "Resources"))
parts.append(group(ids["gTests"], "CzerwonaTeczkaTests", [file_ids["LessonPackTests.swift"]], "CzerwonaTeczkaTests"))
parts.append(group(ids["products"], "Products", [ids["appProduct"], ids["testProduct"]]))
parts.append(group(
    ids["mainGroup"],
    "CzerwonaTeczka",
    [ids["gApp"], ids["gEngine"], ids["gViews"], ids["gWorld"], ids["gRes"], ids["gTests"], ids["products"]],
))
parts.append("/* End PBXGroup section */\n\n")

parts.append("/* Begin PBXNativeTarget section */\n")
parts.append(f"""\t\t{ids['appTarget']} /* CzerwonaTeczka */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {ids['appConfigList']};
			buildPhases = (
				{ids['srcBuild']},
				{ids['fwBuild']},
				{ids['resBuild']},
			);
			buildRules = (
			);
			dependencies = (
			);
			name = CzerwonaTeczka;
			productName = CzerwonaTeczka;
			productReference = {ids['appProduct']};
			productType = "com.apple.product-type.application";
		}};
		{ids['testTarget']} /* CzerwonaTeczkaTests */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {ids['testConfigList']};
			buildPhases = (
				{ids['testSrc']},
				{ids['testFw']},
				{ids['testRes']},
			);
			buildRules = (
			);
			dependencies = (
				{uid('dep')} /* PBXTargetDependency */,
			);
			name = CzerwonaTeczkaTests;
			productName = CzerwonaTeczkaTests;
			productReference = {ids['testProduct']};
			productType = "com.apple.product-type.bundle.unit-test";
		}};
""")
parts.append("/* End PBXNativeTarget section */\n\n")

dep_id = uid("dep")
proxy_id = uid("proxy")
parts.append("/* Begin PBXProject section */\n")
parts.append(f"""\t\t{ids['project']} /* Project object */ = {{
			isa = PBXProject;
			attributes = {{
				BuildIndependentProductsByDefault = 1;
				LastSwiftUpdateCheck = 2600;
				LastUpgradeCheck = 2600;
				TargetAttributes = {{
					{ids['appTarget']} = {{
						CreatedOnToolsVersion = 26.0;
					}};
					{ids['testTarget']} = {{
						CreatedOnToolsVersion = 26.0;
						TestTargetID = {ids['appTarget']};
					}};
				}};
			}};
			buildConfigurationList = {ids['projConfigList']};
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = pl;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				pl,
				Base,
			);
			mainGroup = {ids['mainGroup']};
			productRefGroup = {ids['products']};
			projectDirPath = "";
			projectRoot = "";
			targets = (
				{ids['appTarget']},
				{ids['testTarget']},
			);
		}};
""")
parts.append("/* End PBXProject section */\n\n")

src_files = [n for n in files if n != "LessonPackTests.swift"]
res_list = "".join(f"\t\t\t\t{build_ids[n]} /* {n} in Resources */,\n" for n in resources)
src_list = "".join(f"\t\t\t\t{build_ids[n]} /* {n} in Sources */,\n" for n in src_files)
parts.append("/* Begin PBXResourcesBuildPhase section */\n")
parts.append(
    f"\t\t{ids['resBuild']} /* Resources */ = {{\n"
    "\t\t\tisa = PBXResourcesBuildPhase;\n"
    "\t\t\tbuildActionMask = 2147483647;\n"
    "\t\t\tfiles = (\n"
    f"{res_list}"
    "\t\t\t);\n"
    "\t\t\trunOnlyForDeploymentPostprocessing = 0;\n"
    "\t\t};\n"
    f"\t\t{ids['testRes']} /* Resources */ = {{\n"
    "\t\t\tisa = PBXResourcesBuildPhase;\n"
    "\t\t\tbuildActionMask = 2147483647;\n"
    "\t\t\tfiles = (\n"
    f"\t\t\t\t{build_ids['Lessons.json.test']} /* Lessons.json in Resources */,\n"
    "\t\t\t);\n"
    "\t\t\trunOnlyForDeploymentPostprocessing = 0;\n"
    "\t\t};\n"
)
parts.append("/* End PBXResourcesBuildPhase section */\n\n")

parts.append("/* Begin PBXSourcesBuildPhase section */\n")
parts.append(
    f"\t\t{ids['srcBuild']} /* Sources */ = {{\n"
    "\t\t\tisa = PBXSourcesBuildPhase;\n"
    "\t\t\tbuildActionMask = 2147483647;\n"
    "\t\t\tfiles = (\n"
    f"{src_list}"
    "\t\t\t);\n"
    "\t\t\trunOnlyForDeploymentPostprocessing = 0;\n"
    "\t\t};\n"
    f"\t\t{ids['testSrc']} /* Sources */ = {{\n"
    "\t\t\tisa = PBXSourcesBuildPhase;\n"
    "\t\t\tbuildActionMask = 2147483647;\n"
    "\t\t\tfiles = (\n"
    f"\t\t\t\t{build_ids['LessonPackTests.swift']} /* LessonPackTests.swift in Sources */,\n"
    "\t\t\t);\n"
    "\t\t\trunOnlyForDeploymentPostprocessing = 0;\n"
    "\t\t};\n"
)
parts.append("/* End PBXSourcesBuildPhase section */\n\n")

parts.append("/* Begin PBXFrameworksBuildPhase section */\n")
parts.append(f"""\t\t{ids['fwBuild']} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
		{ids['testFw']} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
""")
parts.append("/* End PBXFrameworksBuildPhase section */\n\n")

parts.append("/* Begin PBXContainerItemProxy section */\n")
parts.append(f"""\t\t{proxy_id} /* PBXContainerItemProxy */ = {{
			isa = PBXContainerItemProxy;
			containerPortal = {ids['project']};
			proxyType = 1;
			remoteGlobalIDString = {ids['appTarget']};
			remoteInfo = CzerwonaTeczka;
		}};
""")
parts.append("/* End PBXContainerItemProxy section */\n\n")

parts.append("/* Begin PBXTargetDependency section */\n")
parts.append(f"""\t\t{dep_id} /* PBXTargetDependency */ = {{
			isa = PBXTargetDependency;
			target = {ids['appTarget']};
			targetProxy = {proxy_id};
		}};
""")
parts.append("/* End PBXTargetDependency section */\n\n")

def xcconfig(cid, name, extra, debug=False):
    swift = "SWIFT_OPTIMIZATION_LEVEL = -Onone;\n\t\t\t\tSWIFT_ACTIVE_COMPILATION_CONDITIONS = \"DEBUG $(inherited)\";\n\t\t\t\tGCC_OPTIMIZATION_LEVEL = 0;\n\t\t\t\tENABLE_TESTABILITY = YES;" if debug else "SWIFT_COMPILATION_MODE = wholemodule;\n\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = -O;"
    return f"""\t\t{cid} /* {name} */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{{common_proj}
				{swift}
{extra}\t\t\t}};
			name = {name.split()[-1] if False else name};
		}};
"""

parts.append("/* Begin XCBuildConfiguration section */\n")
# name parsing is messy - just hardcode
parts.append(f"""\t\t{ids['projDebug']} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_OPTIMIZATION_LEVEL = 0;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_APPROACHABLE_CONCURRENCY = YES;
				SWIFT_DEFAULT_ACTOR_ISOLATION = nonisolated;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_STRICT_CONCURRENCY = targeted;
				SWIFT_VERSION = 5.0;
			}};
			name = Debug;
		}};
		{ids['projRelease']} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				SDKROOT = iphoneos;
				SWIFT_APPROACHABLE_CONCURRENCY = YES;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_DEFAULT_ACTOR_ISOLATION = nonisolated;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				SWIFT_STRICT_CONCURRENCY = targeted;
				SWIFT_VERSION = 5.0;
				VALIDATE_PRODUCT = YES;
			}};
			name = Release;
		}};
		{ids['appDebug']} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{{app_build}\t\t\t}};
			name = Debug;
		}};
		{ids['appRelease']} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{{app_build}\t\t\t}};
			name = Release;
		}};
		{ids['testDebug']} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{{test_build}\t\t\t}};
			name = Debug;
		}};
		{ids['testRelease']} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{{test_build}\t\t\t}};
			name = Release;
		}};
""")
parts.append("/* End XCBuildConfiguration section */\n\n")

parts.append("/* Begin XCConfigurationList section */\n")
parts.append(f"""\t\t{ids['projConfigList']} /* Build configuration list for PBXProject */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{ids['projDebug']},
				{ids['projRelease']},
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{ids['appConfigList']} /* Build configuration list for PBXNativeTarget "CzerwonaTeczka" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{ids['appDebug']},
				{ids['appRelease']},
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
		{ids['testConfigList']} /* Build configuration list for PBXNativeTarget "CzerwonaTeczkaTests" */ = {{
			isa = XCConfigurationList;
			buildConfigurations = (
				{ids['testDebug']},
				{ids['testRelease']},
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		}};
""")
parts.append("/* End XCConfigurationList section */\n")

parts.append(f"\t}};\n\trootObject = {ids['project']} /* Project object */;\n}}\n")

proj_dir = ROOT / "CzerwonaTeczka.xcodeproj"
proj_dir.mkdir(exist_ok=True)
(proj_dir / "project.pbxproj").write_text("".join(parts))

scheme_dir = proj_dir / "xcshareddata" / "xcschemes"
scheme_dir.mkdir(parents=True, exist_ok=True)
scheme = f"""<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "2600"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "{ids['appTarget']}"
               BuildableName = "CzerwonaTeczka.app"
               BlueprintName = "CzerwonaTeczka"
               ReferencedContainer = "container:CzerwonaTeczka.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES">
      <Testables>
         <TestableReference
            skipped = "NO">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "{ids['testTarget']}"
               BuildableName = "CzerwonaTeczkaTests.xctest"
               BlueprintName = "CzerwonaTeczkaTests"
               ReferencedContainer = "container:CzerwonaTeczka.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "{ids['appTarget']}"
            BuildableName = "CzerwonaTeczka.app"
            BlueprintName = "CzerwonaTeczka"
            ReferencedContainer = "container:CzerwonaTeczka.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "{ids['appTarget']}"
            BuildableName = "CzerwonaTeczka.app"
            BlueprintName = "CzerwonaTeczka"
            ReferencedContainer = "container:CzerwonaTeczka.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
"""
(scheme_dir / "CzerwonaTeczka.xcscheme").write_text(scheme)
print("xcodeproj written", ids["appTarget"])
