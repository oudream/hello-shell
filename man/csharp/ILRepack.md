
### ILRepack 是 ILMerge 的一个流行替代品
- https://github.com/gluck/il-repack
- https://github.com/dotnet/ILMerge
```text
截至我最后更新的信息（2023年4月），对于需要合并.NET程序集的场景，ILRepack 是 ILMerge 的一个流行替代品。它是一个开源工具，
用于合并多个.NET程序集成为一个单一的程序集，类似于 ILMerge 的功能。
```
```shell
ILRepack.exe /out:MergedAssembly.dll /internalize PrimaryAssembly.dll SecondaryAssembly.dll
```


### ILRepack 也提供了一个 internalize 选项，这个功能非常有用，尤其是当你需要避免命名空间冲突时。使用 internalize 选项，
### ILRepack 会将所有合并的程序集中的公开（public）类型改为内部（internal）类型，除非这些类型属于主程序集。这有助于减少不同程序集间由于公共类型重复导致的冲突。


###
```shell
Syntax: ILRepack.exe [options] /out:<path> <path_to_primary> [<other_assemblies> ...]

 - /help                displays this usage
 - /keyfile:<path>      specifies a keyfile to sign the output assembly
 - /keycontainer:<name> specifies a key container to sign the output assembly (takes precedence over /keyfile)
 - /log:<logfile>       enable logging (to a file, if given) (default is disabled)
 - /ver:M.X.Y.Z         target assembly version
 - /union               merges types with identical names into one
 - /ndebug              disables symbol file generation
 - /copyattrs           copy assembly attributes (by default only the primary assembly attributes are copied)
 - /attr:<path>         take assembly attributes from the given assembly file
 - /allowMultiple       when copyattrs is specified, allows multiple attributes (if type allows)
 - /target:kind         specify target assembly kind (library, exe, winexe supported, default is same as first assembly)
 - /targetplatform:P    specify target platform (v1, v1.1, v2, v4 supported)
 - /xmldocs             merges XML documentation as well
 - /lib:<path>          adds the path to the search directories for referenced assemblies (can be specified multiple times)
 - /internalize[:<excludefile>]  sets all types but the ones from the first assembly 'internal'. <excludefile> contains one regex per
                                 line to compare against FullName of types NOT to internalize.
 - /renameInternalized  rename all internalized types
 - /delaysign           sets the key, but don't sign the assembly
 - /usefullpublickeyforreferences - NOT IMPLEMENTED
 - /align               - NOT IMPLEMENTED
 - /closed              - NOT IMPLEMENTED
 - /allowdup:Type       allows the specified type for being duplicated in input assemblies
 - /allowduplicateresources allows to duplicate resources in output assembly (by default they're ignored)
 - /zeropekind          allows assemblies with Zero PeKind (but obviously only IL will get merged)
 - /wildcards           allows (and resolves) file wildcards (e.g. `*`.dll) in input assemblies
 - /parallel            use as many CPUs as possible to merge the assemblies
 - /pause               pause execution once completed (good for debugging)
 - /repackdrop:AttributeClass allows dropping specific members during merging (#215)
 - /verbose             shows more logs
 - /out:<path>          target assembly path, symbol/config/doc files will be written here as well
 - <path_to_primary>    primary assembly, gives the name, version to the merged one
 - <other_assemblies>   ...

Note: for compatibility purposes, all options can be specified using '/', '-' or '--' prefix.
```