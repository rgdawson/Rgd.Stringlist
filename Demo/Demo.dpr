program Demo;

uses
  Vcl.Forms,
  DemoForm in 'DemoForm.pas' {MainForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
