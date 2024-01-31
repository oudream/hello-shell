type Heartbeat struct {
	ProgramId int64 `json:"ProgramId"`
	PId       int   `json:"PId"`
	Healthy   int   `json:"Healthy"`
	Res1      int   `json:"Res1"`
	Res2      int   `json:"Res2"`
	Res3      int   `json:"Res3"`
	Res4      int   `json:"Res4"`
}


public struct AoLeiStatus
{
int OvercurrentProtection;    // 过流保护
int OvervoltageProtection;    // 过压保护
int PowerSupplyAlarm;         // 电源报警指示
int InterlockIndicator;       // 互锁指示
int HighPressureOffIndicator; // 高压关状态指示
int HighPressureOnIndicator;  // 高压开状态指示
int RemoteModeIndicator;      // 远程模式指示
int HighPressureOnIndicator2; // 高压开指示
int OverPowerProtection;      // 过功率保护
int LocalModeIndicator;       // 本地模式指示
}
            Console.WriteLine($"过流保护: {overcurrentProtection}");
            Console.WriteLine($"过压保护: {overvoltageProtection}");
            Console.WriteLine($"电源报警指示: {powerSupplyAlarm}");
            Console.WriteLine($"互锁指示: {interlockIndicator}");
            Console.WriteLine($"高压关状态指示: {highPressureOffIndicator}");
            Console.WriteLine($"高压开状态指示: {highPressureOnIndicator}");
            Console.WriteLine($"远程模式指示: {remoteModeIndicator}");
            Console.WriteLine($"高压开指示: {highPressureOnIndicator2}");
            Console.WriteLine($"过功率保护: {overPowerProtection}");
            Console.WriteLine($"本地模式指示: {localModeIndicator}");