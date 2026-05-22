#!/bin/sh
# statusline-command.sh — Claude Code status line
# Format: Sonnet 4.6 (200k ctx) | ctx ━━━━┄┄┄┄┄┄ 40% (80k) | 5h:35% | 7d:59%
input=$(cat)

# Parse all fields in one python call to avoid repeated process spawns
eval "$(echo "$input" | python3 -c "
import sys, json, math

d = json.load(sys.stdin)

# --- Model ---
display = d.get('model', {}).get('display_name', 'Unknown')
# Strip leading 'Claude ' so 'Claude Opus 4.6' -> 'Opus 4.6'
short = display.removeprefix('Claude ').strip()
print('model=' + repr(short))

# --- Context window ---
cw = d.get('context_window', {})
used_pct  = cw.get('used_percentage')
rem_pct   = cw.get('remaining_percentage')
ctx_size  = cw.get('context_window_size') or 0
if used_pct is not None and ctx_size:
    input_tok = round(used_pct / 100 * ctx_size)
else:
    cur_usage = cw.get('current_usage')
    input_tok = (cur_usage or {}).get('input_tokens') or cw.get('total_input_tokens') or 0

def fmt(n):
    if n >= 1_000_000:
        v = n / 1_000_000
        return (f'{v:.1f}M' if v % 1 else f'{int(v)}M')
    elif n >= 1_000:
        v = n / 1_000
        return (f'{v:.1f}k' if v % 1 else f'{int(v)}k')
    return str(n)

print('used_pct=' + repr(str(round(used_pct)) if used_pct is not None else ''))
print('rem_pct='  + repr(str(round(rem_pct))  if rem_pct  is not None else ''))
print('ctx_size_fmt=' + repr(fmt(ctx_size) if ctx_size else ''))
print('input_tok_fmt=' + repr(fmt(input_tok) if input_tok else ''))

# --- Rate limits ---
rl = d.get('rate_limits', {})
fh = rl.get('five_hour', {}).get('used_percentage')
sd = rl.get('seven_day', {}).get('used_percentage')
print('five_pct=' + repr(str(round(fh)) if fh is not None else ''))
print('seven_pct=' + repr(str(round(sd)) if sd is not None else ''))
")"

# --- Progress bar (10 chars wide) ---
# filled = ━ (U+2501), empty = ┄ (U+2504)
if [ -n "$used_pct" ]; then
  filled=$(python3 -c "print(round(${used_pct} / 10))")
  empty=$((10 - filled))
  bar=""
  i=0
  while [ $i -lt $filled ]; do bar="${bar}━"; i=$((i+1)); done
  i=0
  while [ $i -lt $empty ];  do bar="${bar}┄"; i=$((i+1)); done
else
  bar="┄┄┄┄┄┄┄┄┄┄"
fi

# --- Assemble segments ---
# Segment 1: model + ctx size
if [ -n "$ctx_size_fmt" ]; then
  seg_model="${model} (${ctx_size_fmt} ctx)"
else
  seg_model="$model"
fi

# Segment 2: ctx bar + used% + used tokens
if [ -n "$used_pct" ] && [ -n "$input_tok_fmt" ]; then
  seg_ctx="ctx ${bar} ${used_pct}% (${input_tok_fmt})"
elif [ -n "$used_pct" ]; then
  seg_ctx="ctx ${bar} ${used_pct}%"
else
  seg_ctx="ctx ${bar} --%"
fi

# Segment 3+4: rate limits (only shown when data is available)
seg_rate=""
if [ -n "$five_pct" ] && [ -n "$seven_pct" ]; then
  seg_rate="5h:${five_pct}% | 7d:${seven_pct}%"
elif [ -n "$five_pct" ]; then
  seg_rate="5h:${five_pct}%"
elif [ -n "$seven_pct" ]; then
  seg_rate="7d:${seven_pct}%"
fi

# --- Print with ANSI colors ---
# model: magenta, ctx: cyan, rate: yellow
if [ -n "$seg_rate" ]; then
  printf '\033[35m%s\033[0m | \033[36m%s\033[0m | \033[33m%s\033[0m' \
    "$seg_model" "$seg_ctx" "$seg_rate"
else
  printf '\033[35m%s\033[0m | \033[36m%s\033[0m' \
    "$seg_model" "$seg_ctx"
fi
