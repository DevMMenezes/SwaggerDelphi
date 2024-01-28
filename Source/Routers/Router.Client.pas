unit Router.Client;

interface

uses
  Horse,
  Horse.GBSwagger,
  System.JSON,
  Models.Client;

procedure LoadRouters;
procedure pGetFindAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure pGetFindByID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure pPostInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure pPutUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure pDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  Service.Client, System.SysUtils;

procedure LoadRouters;
begin

  THorse.Get('/client', pGetFindAll);
  THorse.Get('/client/:id', pGetFindByID);
  THorse.Post('/client', pPostInsert);
  THorse.Put('/client', pPutUpdate);
  THorse.Delete('/client/:id', pDelete);

end;

procedure pGetFindByID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iStatusCode: Integer;
begin

  Res.Send<TJSONObject>(TServiceClient.New.FindByID(Req.Params.Field('id')
    .AsInteger, iStatusCode)).Status(iStatusCode);

end;

procedure pGetFindAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iStatusCode: Integer;
begin

  Res.Send<TJSONObject>(TServiceClient.New.FindAll(iStatusCode))
    .Status(iStatusCode);

end;

procedure pPostInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iStatusCode: Integer;
begin

  Res.Send<TJSONObject>(TServiceClient.New.Insert(Req.Body<TJSONObject>,
    iStatusCode)).Status(iStatusCode);

end;

procedure pPutUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iStatusCode: Integer;
begin
  Res.Send<TJSONObject>(TServiceClient.New.Update(Req.Body<TJSONObject>,
    iStatusCode)).Status(iStatusCode);

end;

procedure pDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iStatusCode: Integer;
begin

  Res.Send<TJSONObject>(TServiceClient.New.Delete(Req.Params.Field('id')
    .AsInteger, iStatusCode)).Status(iStatusCode);

end;

 initialization
 Swagger
      .Register
        .SchemaOnError(TAPIError)
      .&End
      .Path('client')
        .Tag('client')
        .GET('List All', 'List All Users')
          .AddResponse(200, 'successful operation')
            .Schema(TModelsClient)
            .IsArray(True)
          .&End
          .AddResponse(400).&End
          .AddResponse(500).&End
        .&End
        .POST('Add user', 'Add a new user')
          .AddParamBody('User data', 'User data')
            .Required(True)
            .Schema(TModelsClient)
          .&End
          .AddResponse(201, 'Created')
            .Schema(TModelsClient)
          .&End
          .AddResponse(400).&End
          .AddResponse(500).&End
        .&End
      .&End
    .&End;
end.
