/* eslint-disable max-len */
import { useBackend } from '../backend';
import { Button, Collapsible, Icon, Section, Table, Tooltip } from '../components';
import { Window } from '../layouts';

export const JoinMenu = (props, context) => {
  const { act, data } = useBackend(context);
  const { charname, duration, evacuated, jobs, security_level } = data;
  return (
    <Window width={400} height={600}>
      <Window.Content overflow="auto">
        <Section title={"Welcome " + charname}>
          Shift has lasted {duration}<br />
          The current alert level is {security_level}<br />
          {evacuated ? "The Station is under evacuation procedures." : null}
        </Section>
        <Section title="Join a Shift">
          {
            Object.keys(jobs).map(faction => (
              <Collapsible title={faction} key={faction} color="transparent">
                {
                  Object.keys(jobs[faction]).map(job => (
                    <Collapsible title={job} key={job} color="transparent" style={{ "padding-left": "5%" }}>
                      <Section style={{ "padding-left": "5%" }}>
                        <Table>
                          {
                            Object.keys(jobs[faction][job]).map(rank => (
                              <tr class="Table__row candystripe" key={rank}>
                                <Collapsible title={rank} color="transparent" style={{ "padding-left": "5%" }} buttons={
                                  <>
                                    {jobs[faction][job][rank].slots} <Icon name="user-friends" />
                                    <Button
                                      icon="sign-in-alt"
                                      content="Join"
                                      color="transparent"
                                      // disabled={jobs[faction][job][rank].slots <= 0}
                                      onClick={() => act('join', {
                                        id: jobs[faction][job][rank].id,
                                        type: "job",
                                      })} />
                                  </>
                                }>
                                  <Section style={{ "padding-left": "5%" }}>
                                    Description: {jobs[faction][job][rank].desc}
                                  </Section>
                                </Collapsible>
                              </tr>
                            ))
                          }
                        </Table>
                      </Section>
                    </Collapsible>
                  ))
                }
              </Collapsible>
            ))
          }
        </Section>
      </Window.Content>
    </Window>
  );
};
