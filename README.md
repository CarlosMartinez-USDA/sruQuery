# sruQuery
The **sruQuery repo** consists XSLT transformations  and example XML files. The sample XML  are the results from SRU Queries of the LC catalog, returned using the MODS schema. The query used to retrieve these records is contained within the header of the XML document as a comment. 

LC's MODS records provide a level of detail and description that surpasses others. Thus querying and transforming records via SRU Query is potentially a rich source for new or improved MODS metadata. 


## Specifications:
**SRU- Search/Retrieve via URL -** is a standard XML-based protocol for search queries,  utilizing **CQL - Contextual Query Language** - a standard syntax for representing queries.

### An example SRU Query:

 
    SRU Query: http://lx2.loc.gov:210/lcdb?
               version=1.1&
               operation=searchRetrieve 
               &query=United+States+Department+of+Agriculture
               &startRecord=10&maximumRecords=10
               &recordSchema=mods
    
   Full Query URL: http://lx2.loc.gov:210/lcdb?version=1.1&operation=searchRetrieve&query=United+States+Department+of+Agriculture&startRecord=10&maximumRecords=10&recordSchema=mods

For more SRU Query examples
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc3MjUyNDQyNiwtMTcxMTcxMDQ4MV19
-->